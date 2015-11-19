//
//  Profile.swift
//  HomeInventory
//
//  Created by Jason Shultz on 11/18/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import RealmSwift
import Foundation

class Profile: Object {
    
    dynamic var id = NSUUID().UUIDString
    dynamic var fName = ""
    dynamic var lName = ""
    dynamic var street = ""
    dynamic var city = ""
    dynamic var state = ""
    dynamic var zip = ""
    dynamic var phone = ""
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
}