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
    let dataFIlePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   // var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
//                if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
//                {
//                    itemArray = items
//                }
//
        loadItems()
    }

    
    //MARK: tableview datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: tableview delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
  saveItems()
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
            
            //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.saveItems()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItems()
    {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFIlePath!)
        }
        catch{
            print("error")
        }
        self.tableView.reloadData()
    }
    func loadItems()
    {
        if let data = try? Data(contentsOf: dataFIlePath!)
        {
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }
            catch{
                print("error")
            }
            
            self.tableView.reloadData()
        }
    }
}

