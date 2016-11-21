//
//  Item.swift
//  GroceryAppCoreData
//
//  Created by Fredrick Ohen on 11/17/16.
//  Copyright © 2016 geeoku. All rights reserved.
//

import Foundation
import CoreData

class Item: NSManagedObject {
    
    @NSManaged var itemName: String!
    @NSManaged var groceryList: GroceryList!

}
