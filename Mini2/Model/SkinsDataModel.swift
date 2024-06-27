//
//  DataModel.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 27/06/24.
//

import Foundation
import SwiftData

@Model
class SkinsDataModel: Identifiable {
    var id: Int
    var items: CollectionItem?
    
    init(id: Int = 0, items: CollectionItem? = nil) {
        self.id = id
        self.items = items
    }
}
