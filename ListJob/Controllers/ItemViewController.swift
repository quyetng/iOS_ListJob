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
        print("cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        print("indexPath.row = \(indexPath.row)")
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = todoItems?[indexPath.row].title
        } else {
            cell.textLabel?.text = "No items added yet"
        }
        
        //cell.textLabel?.text = todoItems?[indexPath.row].title ?? "No items added yet"
        return cell
    }
    
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCat = self.selectedCategory {
                
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCat.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
                
                
            }
            
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
    
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        print(todoItems)
        tableView.reloadData()
    }
}

