//
//  ViewController.swift
//  Checklists
//
//  Created by JAM on 3/4/24.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewController {
    
var items = [ChecklistItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let item1 = ChecklistItem()
        item1.text = "Walk the dog"
        items.append(item1)
        
        let item2 = ChecklistItem()
        item2.text = "Brush my teeth"
        items.append(item2)
        
        let item3 = ChecklistItem()
        item3.text = "Learn iOS development"
        items.append(item3)
        
        let item4 = ChecklistItem()
        item4.text = "Soccer practice"
        items.append(item4)
        
        let item5 = ChecklistItem()
        item5.text = "Eat ice cream"
        items.append(item5)

    }
    
    // MARK: - Actions
    
    // MARK: - Table View Data Source
    override func tableView(
        _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
    
    override func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
            
            let item = items[indexPath.row]
            
            let label = cell.viewWithTag(1000) as! UILabel
            
            label.text = item.text
            configureText(for: cell, with: item)
            configureCheckmark(for: cell, with: item)
            return cell
        }
    
    func configureCheckmark(
        for cell: UITableViewCell,
        with item: ChecklistItem) {
            let label = cell.viewWithTag(1001) as! UILabel
            
            if item.checked {
                label.text = "√"
            } else {
                label.text = ""
            }
        }
    
    func configureText(
        for cell: UITableViewCell,
        with item: ChecklistItem) {
            let label = cell.viewWithTag(1000) as! UILabel
            label.text = item.text
        }
    
    // MARK: - Table View Delegates
    override func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if let cell = tableView.cellForRow(at: indexPath) {
                let item = items[indexPath.row]
                item.checked.toggle()
                configureCheckmark(for: cell, with: item)
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
            

        }
    
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
            items.remove(at: indexPath.row)
            
            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic)
        }
    
    // MARK: - Add Item ViewController Delegates
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
        
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(
        _ controller: AddItemViewController,
        didFinishEditing item: ChecklistItem) {
            if let index = items.firstIndex(of: item) {
                let indexPath = IndexPath(row: index, section: 0)
                if let cell = tableView.cellForRow(at: indexPath) {
                    configureText(for: cell, with: item)
                }
            }
            navigationController?.popViewController(animated: true)
        }
    
    // MARK: - Navigation
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?) {
            if segue.identifier == "AddItem" {
                let controller = segue.destination as! AddItemViewController
                controller.delegate = self
            } else if segue.identifier == "EditItem" {
                let controller = segue.destination as! AddItemViewController
                controller.delegate = self
                
                if let indexPath = tableView.indexPath(
                    for: sender as! UITableViewCell) {
                    controller.itemToEdit = items[indexPath.row]
                }
            }
        }


}

