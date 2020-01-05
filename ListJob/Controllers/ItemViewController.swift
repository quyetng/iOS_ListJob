//
//  ViewController.swift
//  ListJob
//
//  Created by QN on 1/2/20.
//  Copyright © 2020 QN. All rights reserved.
//

import UIKit
import RealmSwift

class ItemViewController: UITableViewController {

    var realm = try! Realm()
    
    var todoItems: Results<Item>?
    
    var selectedCategory: Category? {
        didSet {
            loadItem()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadItem();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = selectedCategory!.title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        cell.textLabel?.text = todoItems?[indexPath.row].title ?? "No items added yet"
        return cell
    }
    
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            
            self.saveItem(item: newItem)
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItem(item: Item) {
        do {
            try realm.write{
                realm.add(item)
            }
        } catch {
            print("Error saving context, \(error)")
        }
    }
    func loadItem() {
    
        todoItems = realm.objects(Item.self)
        tableView.reloadData()
    }
}

