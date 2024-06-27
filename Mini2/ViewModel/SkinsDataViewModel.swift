//
//  SkinsDataViewModel.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 27/06/24.
//

import Foundation
import SwiftData
import SwiftUI

class SkinsDataViewModel {
    static func populateModel(_ seedData: [CollectionItem], _ dataModel: ModelContext) {
        let chickenSkins = seedData
        var index = 0

        for chicken in chickenSkins {
            let chickModel = SkinsDataModel(id: index, items: chicken)
            dataModel.insert(chickModel)
            index += 1
        }
    }
    
    static func fetchItems(_ datas: [SkinsDataModel], _ dataModel: ModelContext) -> [CollectionItem] {
        var items = [CollectionItem]()
        
        for data in datas {
            items.append(data.items!)
        }
        
        return items
    }
    
    static func unlockChicken(_ index: Int, _ skinsData: [SkinsDataModel], _ dataModel: ModelContext) {
        let data = skinsData[index]
        data.items?.locked = false
        
        try? dataModel.save()
    }
}
