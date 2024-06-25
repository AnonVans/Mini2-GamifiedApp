//
//  UserModelData.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 21/06/24.
//

import Foundation

class UserDataModel {
    var poin: Int
    var chicken: Chicken
    
    init(poin: Int = 0, chicken: Chicken = Chicken()) {
        self.poin = poin
        self.chicken = chicken
    }
}
