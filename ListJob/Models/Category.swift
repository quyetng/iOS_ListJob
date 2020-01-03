//
//  Category.swift
//  ListJob
//
//  Created by QN on 1/2/20.
//  Copyright © 2020 QN. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var title: String = ""
    
    let items = List<Item>()
}
