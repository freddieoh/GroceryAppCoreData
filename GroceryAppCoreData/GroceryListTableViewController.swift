//
//  GroceryListTableViewController.swift
//  GroceryAppCoreData
//
//  Created by Fredrick Ohen on 11/15/16.
//  Copyright © 2016 geeoku. All rights reserved.
//

import UIKit
import CoreData

class GroceryListTableViewController: UITableViewController {

    var managedObjectContext: NSManagedObjectContext!

    var groceryLists: [GroceryList]!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.groceryLists = [GroceryList]()
        populateGroceryList()
    }

    func populateGroceryList() {
        
        let request = NSFetchRequest<GroceryList>(entityName: "GroceryList")
        self.groceryLists = try! self.managedObjectContext.fetch(request)
        
        self.tableView.reloadData()

    }
    
    @IBAction func addNewGroceryButtonPressed() {
        
        let alertController = UIAlertController(title: "Looks like you want to add something", message: "Add something?!", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: ( {
            (_) in
            if let textField = alertController.textFields![0] as? UITextField  {
                self.saveStore(storeToSave: textField.text!)
            }
            }
        ))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField(configurationHandler: {
            (UITextField) in
            
            UITextField.placeholder = "Type something"

        })
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
    self.present(alertController, animated: true, completion: nil)

        }

    func saveStore(storeToSave: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let store = NSEntityDescription.insertNewObject(forEntityName: "GroceryList", into: appDelegate.managedObjectContext) as! GroceryList
            store.name = storeToSave

        do {
            try! appDelegate.managedObjectContext.save()
            groceryLists.append(store)
            self.tableView.reloadData()
            
        } catch {
            print("Error")
        }
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groceryLists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroceryCell", for: indexPath)

        cell.textLabel?.text = self.groceryLists[indexPath.row].name

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            self.groceryLists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            managedObjectContext.delete(groceryLists[indexPath.row])
            try! managedObjectContext.save()

        } else if editingStyle == .insert {
           self.tableView.reloadData()
    
        }    
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            let itemTableViewController: ItemTableViewController = segue.destination as! ItemTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            let selectedRowIndex = (indexPath?.row)!
            let selectedGroceryStore = groceryLists[selectedRowIndex]
            itemTableViewController.selectedGroceryStore = selectedGroceryStore
      
        }
    }

}
