//
//  Enumeration.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 24/06/24.
//

import Foundation

enum TimerType: String {
    case Swiper = "Swipe"
    case Regular = "Reg"
    case Break = "Break"
}

enum WarningType: Int {
    case FailBreak = -1
    case FailCatch = 0
}

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

enum ChickenSkin: String, Codable {
    case Default = "Default"
    case Detective = "Detective"
    case Business = "Business"
    case Egg = "Egg"
    case Farmer = "Farmer"
    case Ironman = "Ironman"
    case Luffy = "Luffy"
    case Nurse = "Nurse"
    case Romairama = "Romairama"
    case Mermaid = "Mermaid"
}

enum ChickentState: String, Codable {
    case Normal = "Normal"
    case Happy = "Happy"
    case Scared = "Scared"
}

enum ChickenPose: String, Codable {
    case LookLeft = "LookLeft"
    case LookRight = "LookRight"
    case HandsUp = "HandsUp"
}

enum SessionState {
    case StudySession
    case StudyActivity
    case EggCatch
    case LateToBreak
    case FailedToCatch
    case ChooseEggs
    case OpenEggs
    case StartBreak
    case BreakSession
    case BreakActivity
    case BreakActivityFailed
    case BreakActivitySuccess
}

enum UserDataEnum: String {
    case Chicken = "DefaultChicken"
    case Poin = "UserPoin"
}

enum EggRevealType {
    case Regular
    case SpecialLaunch
}

