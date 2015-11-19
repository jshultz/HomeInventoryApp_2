//
//  Rooms.swift
//  HomeInventory
//
//  Created by Jason Shultz on 11/18/15.
//  Copyright © 2015 Chaos Elevators, Inc.. All rights reserved.
//

import RealmSwift
import Foundation

class Room: Object {
    
    dynamic var id = NSUUID().UUIDString
    dynamic var name = ""
    dynamic var room_description = ""
    let items = List<Inventory>()
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
