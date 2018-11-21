//
//  ViewController.swift
//  To Do List
//
//  Created by Divyanshu Pipal on 11/20/18.
//  Copyright © 2018 Divyanshu Pipal. All rights reserved.
//

import UIKit

class Todolistviewcontroller: UITableViewController {
    
    var itemArray = ["Buy eggs", "Buy milk", "Buy chicken"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey:"To do list array" ) as? [String]{
            
            itemArray = items
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "To Do List", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell 
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

            }
        
        else{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }

        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new to do list item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            //print("Success")
            
           // print(textField.text)
            
            self.itemArray.append(textField.text! )
            
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


