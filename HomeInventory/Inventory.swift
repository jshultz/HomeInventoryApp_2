//
//  Inventory.swift
//  HomeInventory
//
//  Created by Jason Shultz on 11/18/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import RealmSwift
import Foundation

class Inventory: Object {
    
    dynamic var id = NSUUID().UUIDString
    dynamic var name = ""
    dynamic var item_description = ""
    dynamic var purchased_date = ""
    dynamic var purchase_price = ""
    dynamic var room: Room? // Can be optional
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
}
