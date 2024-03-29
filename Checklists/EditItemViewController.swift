//
//  AddItemViewController.swift
//  Checklists
//
//  Created by JAM on 3/6/24.
//

import UIKit

protocol ItemDetailViewController: AnyObject {
    func addItemViewControllerDidCancel(
        _ controller: AddItemViewController)
    func addItemViewController(
        _ controller: AddItemViewController,
        didFinishAdding item: ChecklistItem)
    func addItemViewController(
        _ controller: AddItemViewController,
        didFinishEditing item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.addItemViewController(
            self,
            didFinishEditing: item)
        } else {
            let item = ChecklistItem()
            item.text = textField.text!
            delegate?.addItemViewController(self, didFinishAdding: item)
        }
    }
    
    weak var delegate: ItemDetailViewController?
    var itemToEdit: ChecklistItem?
    
    // MARK: - Table View Delegates
    override func tableView(
        _ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath) -> IndexPath? {
            return nil
        }
    
    // MARK: - Text Field Delegates
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
            let oldText = textField.text!
            let stringRange = Range(range, in: oldText)!
            let newText = oldText.replacingCharacters(in: stringRange, with: string)
            if newText.isEmpty {
                doneBarButton.isEnabled = false
            } else {
                doneBarButton.isEnabled = true
            }
            return true
        }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
}
