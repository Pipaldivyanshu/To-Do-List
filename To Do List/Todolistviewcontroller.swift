//
//  ViewController.swift
//  To Do List
//
//  Created by Divyanshu Pipal on 11/20/18.
//  Copyright © 2018 Divyanshu Pipal. All rights reserved.
//

import UIKit

class Todolistviewcontroller: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem  = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        
        let newItem2  = Item()
        newItem.title = "Buy Eggs"
        itemArray.append(newItem2)
        
        
        let newItem3  = Item()
        newItem.title = "Get Milk"
        itemArray.append(newItem3)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey:"To do list array" ) as? [Item]{

            itemArray = items

        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todoitemcell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
//
        
        
        return cell 
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
       tableView.reloadData()

        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new to do list item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            //print("Success")
            
           // print(textField.text)
            
            let newItem = Item()
            newItem.title = textField.text!
           self.itemArray.append(newItem)
            
           self.defaults.set(self.itemArray, forKey: "To do list array")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
        
            alertTextField.placeholder = "Create new item"
            
          //  print(alertTextField.text)
            
            textField = alertTextField
            
        }
        
    alert.addAction(action)
        
        present(alert, animated: true, completion: nil  )
        
        
            
    }
        
    
    
        
    
    
}


