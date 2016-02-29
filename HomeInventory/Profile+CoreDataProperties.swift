//
//  Profile+CoreDataProperties.swift
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

extension Profile {

    @NSManaged var city: String?
    @NSManaged var fName: String?
    @NSManaged var id: NSNumber?
    @NSManaged var lName: String?
    @NSManaged var phone: String?
    @NSManaged var state: String?
    @NSManaged var street: String?
    @NSManaged var zip: NSNumber?

}
