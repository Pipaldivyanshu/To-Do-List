//
//  CategoryViewControllerTableViewController.swift
//  To Do List
//
//  Created by Divyanshu Pipal on 11/29/18.
//  Copyright © 2018 Divyanshu Pipal. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewControllerTableViewController: UITableViewController {
    
    var newListArray = [Category]()
   
    // Grab a reference to the context that we are going to use in order to create read update and delete data and that it communicates with the persistent container.
    
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }

      //Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
           self.newListArray.append(newCategory)
            
            self.saveCategories()
            
            //self.defaults.set(self.newListArray, forKey: "AddNewCategory")
            
            self.tableView.reloadData()
        
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            
             textField = field
            field.placeholder =  "Create new category"
            
            
        }
        
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    // Table Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newListArray.count
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
    
        
        
       category.textLabel?.text = newListArray[indexPath.row].name
        
        return category
    }
    
    
    
    
    
    
    //TableView Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! Todolistviewcontroller
        
        if  let indexPath = tableView.indexPathForSelectedRow{
            
            destinationVC.selectedCategory = newListArray[indexPath.row]
            
        }
        
    }
    
    
    
    // Data Manipulation Methods
    
    func saveCategories(){
        
        
        do{
            try context.save()
        }
        catch{
            
            print("Error saving category \(error)")
            
        }
        self.tableView.reloadData()
        
        
    }
    
    func loadCategories(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        
           let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            newListArray = try context.fetch(request)
        }
        catch{
            
            print("Error loading categories \(error)")
        }
    }
    
}

