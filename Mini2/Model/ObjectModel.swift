//
//  ObjectModel.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 24/06/24.
//

import Foundation

struct CollectionItem: Hashable, Codable {
    var chicken: Chicken
    var locked: Bool
    
    init(chicken: Chicken = Chicken(), locked: Bool = true) {
        self.chicken = chicken
        self.locked = locked
    }
}

struct Chicken: Hashable, Codable {
    var skin: ChickenSkin
    var state: ChickentState
    var pose: ChickenPose
    
    init(skin: ChickenSkin = .Detective, state: ChickentState = .Normal, pose: ChickenPose = .LookLeft) {
        self.skin = skin
        self.state = state
        self.pose = pose
    }
    
    func isSame(_ chick: Chicken) -> Bool {
        return (
            self.skin == chick.skin &&
            self.state == chick.state &&
            self.pose == chick.pose
        )
    }
    
    func getChickenName() -> String {
        let name = self.skin.rawValue + self.state.rawValue + self.pose.rawValue
        
        return name
    }
}

