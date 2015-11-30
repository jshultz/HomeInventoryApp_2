//
//  string_extension.swift
//  HomeInventory
//
//  Created by Jason Shultz on 11/29/15.
//  Copyright © 2015 HashRocket. All rights reserved.
//

import Foundation

extension String {
    func trunc(length: Int, trailing: String? = "...") -> String {
        if self.characters.count > length {
            return self.substringToIndex(self.startIndex.advancedBy(length)) + (trailing ?? "")
        } else {
            return self
        }
    }
}