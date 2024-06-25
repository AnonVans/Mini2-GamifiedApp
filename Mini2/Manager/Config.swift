//
//  Enumeration.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 24/06/24.
//

import Foundation

enum ButtonType {
    case Solid
    case Outline
}

enum ButtonSize {
    case Large
    case Medium
}

enum BreakState {
    case Activity
    case ActivitySuccess
    case ActivityFailed
}

enum GachaState {
    case ChooseEggs
    case OpenEggs
}

enum ChickenSkin: String {
    case Default = "Default"
}

enum ChickentState: String {
    case Normal = "Normal"
    case Happy = "Happy"
    case worried = "Worried"
    case Scared = "Scared"
}

enum ChickenPose: String {
    case Regular = "LookLeft"
    case Reverse = "LookRight"
    case Celebrate = "HandsUp"
}

enum SessionState {
    case StudySession
    case CallToBreak
    case LateToBreak
    case EggCatch
    case FailedToCatch
    case ChooseEggs
    case OpenEggs
    case BreakSession
    case BreakActivity
    case BreakActivityFailed
    case BreakActivitySuccess
}
