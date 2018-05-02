//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Sneha Patel on 26/04/18.
//  Copyright © 2018 Sneha Patel. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let newItem = Item()
        newItem.title = "One"
        itemArray.append(newItem)
        let newItem1 = Item()
        newItem1.title = "Two"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Three"
        itemArray.append(newItem2)
        
                if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
                {
                    itemArray = items
                }
        
    }

    
    //MARK: tableview datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
//        if itemArray[indexPath.row].done == true
//        {
//            cell.accessoryType = .checkmark
//        }
//        else{
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: tableview delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        }
//        else{
//            itemArray[indexPath.row].done = false
//        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    //MARK - bar button Item pressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
         var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "create new item"
            textfield = alertTextfield
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newitem = Item()
            newitem.title = textfield.text!
            self.itemArray.append(newitem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

