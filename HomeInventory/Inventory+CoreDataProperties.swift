//
//  Inventory+CoreDataProperties.swift
//  HomeInventory
//
//  Created by Jason Shultz on 10/28/15.
//  Copyright © 2015 HashRocket. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Inventory {

    @NSManaged var id: NSNumber?
    @NSManaged var name: String?

}
