//
//  Item.swift
//  ListJob
//
//  Created by QN on 1/2/20.
//  Copyright © 2020 QN. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    
    //var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
