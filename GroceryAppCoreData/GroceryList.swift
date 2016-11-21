//
//  GroceryList.swift
//  GroceryAppCoreData
//
//  Created by Fredrick Ohen on 11/15/16.
//  Copyright © 2016 geeoku. All rights reserved.
//

import Foundation
import CoreData


class GroceryList: NSManagedObject {
    
    @NSManaged var name: String!
    @NSManaged var items: Set<Item>!
}
