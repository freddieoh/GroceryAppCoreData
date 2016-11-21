//
//  ItemTableViewController.swift
//  GroceryAppCoreData
//
//  Created by Fredrick Ohen on 11/17/16.
//  Copyright © 2016 geeoku. All rights reserved.
//

import UIKit
import CoreData

class ItemTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var items: [Item]!
    var selectedGroceryStore: GroceryList!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.items = [Item]()

    }

    @IBAction func addNewItemButtonPressed() {
        
        let alertController = UIAlertController(title: "Do you wish to add an item?!", message: "New Item eh?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: ( {
            (_) in
           
            if let textField = alertController.textFields![0] as? UITextField {
                self.saveNewItem(item: textField.text!)
           
            }
            }
        ))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField(configurationHandler: {
            (UITextField) in
            
            UITextField.placeholder = "Insert Item Here ^_^"

        })

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    
    }
 
    func saveNewItem(item: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Item", into: appDelegate.managedObjectContext) as! Item

        newItem.itemName = item
        newItem.groceryList = self.selectedGroceryStore
        
        do {
            try! appDelegate.managedObjectContext.save()
            self.items.append(newItem)
            self.tableView.reloadData()
        }
        catch {
            print("Item is not saving")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedGroceryStore.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)

        let itemsArray = Array(self.selectedGroceryStore.items)
        cell.textLabel?.text = itemsArray[indexPath.row].itemName

        return cell
    }
    

 

}
