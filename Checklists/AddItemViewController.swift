//
//  AddItemViewController.swift
//  Checklists
//
//  Created by JAM on 3/6/24.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Actions
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done() {
        navigationController?.popViewController(animated: true)
    }
    
}