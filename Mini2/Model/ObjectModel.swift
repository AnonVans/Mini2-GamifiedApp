//
//  ObjectModel.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 24/06/24.
//

import Foundation

class Chicken {
    var skin: ChickenSkin
    var state: ChickentState
    var pose: ChickenPose
    
    init(skin: ChickenSkin = .Default, state: ChickentState = .Normal, pose: ChickenPose = .Regular) {
        self.skin = skin
        self.state = state
        self.pose = pose
    }
}
