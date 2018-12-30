//
//  ViewController.swift
//  To Do List
//
//  Created by Divyanshu Pipal on 11/20/18.
//  Copyright © 2018 Divyanshu Pipal. All rights reserved.
//

import UIKit
import CoreData

class Todolistviewcontroller: UITableViewController {
    
    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        
        didSet{
            
            loadItems()
        }
        
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
         
        
        
      //  print(dataFilePath)
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        
        // Do any additional setup after loading the view, typically from a nib.
        
//        if let items = defaults.array(forKey:"To do list array" ) as? [Item]{
//
//            itemArray = items
//
//        }
        
        //searchBar.delegate = self
        
        //  loadItems()
    }
    
    // TableView DataSource Methods

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
    
    //TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)

        
   itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
       tableView.reloadData()

        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new to do list item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            //print("Success")
            
           // print(textField.text)
            
            

            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
           self.itemArray.append(newItem)
            
            self.saveItems()
            
           
        }
        
        alert.addTextField { (alertTextField) in
        
            alertTextField.placeholder = "Create new item"
            
          //  print(alertTextField.text)
            
            textField = alertTextField
            
        }
        
    alert.addAction(action)
        
        present(alert, animated: true, completion: nil  )
        
        
            
    }
        
    //Model Manipulation Methods
    
    func saveItems(){
        
        
        
        
        do{
            try context.save()
        }
        catch{
            
            print("Error saving message \(error)")
            
        }
        self.tableView.reloadData()
        
        
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(),  predicate: NSPredicate? = nil){
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@ ", selectedCategory!.name!)
//
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//        request.predicate = compoundPredicate
//
        if let additionalPredicate = predicate{
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
            
        }
        
        else{
            
            request.predicate = categoryPredicate
        }
        
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//        request.predicate = compoundPredicate

     //   let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do{
     itemArray = try context.fetch(request)
        }
        catch{
            
            print("Error fetching  data from context \(error)")
        }
    }
    
    
    
    
}

// Search Bar Methods

extension Todolistviewcontroller : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        
        
     request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        
        loadItems(with: request, predicate: predicate)
        
        
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            loadItems()
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()

                
                
            }
            
            
        }
        
        
    }
    
    
}
