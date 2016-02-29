//
//  Inventory+CoreDataProperties.swift
//  HomeInventory
//
//  Created by Jason Shultz on 2/27/16.
//  Copyright © 2016 HashRocket. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Inventory {

    @NSManaged var id: NSNumber?
    @NSManaged var item_description: String?
    @NSManaged var name: String?
    @NSManaged var photo: String?
    @NSManaged var purchase_price: NSDecimalNumber?
    @NSManaged var purchased_date: NSDate?
    @NSManaged var room: String?
    @NSManaged var items_to_rooms: Rooms?

}
