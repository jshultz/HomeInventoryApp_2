//
//  Profile+CoreDataProperties.swift
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

extension Profile {

    @NSManaged var id: NSNumber?
    @NSManaged var fName: String?
    @NSManaged var lName: String?
    @NSManaged var street: String?
    @NSManaged var city: String?
    @NSManaged var state: String?
    @NSManaged var zip: NSNumber?

}
