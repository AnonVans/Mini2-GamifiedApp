//
//  StudySessionModel.swift
//  Mini2
//
//  Created by Jovanna Melissa on 23/06/24.
//

import Foundation
import SwiftData

@Model
class StudySessionModel:Identifiable{
    var totalStudySessions: Int
    var totalBreakSessions: Int
    var studySessionTime: [Int]
    var breakSessionTime: [Int]
    var studySessionDone: Int = 0
    var breakSessionDone: Int = 0
    
    init(totalStudySessions: Int, totalBreakSessions: Int, studySessionTime: [Int], breakSessionTime: [Int]) {
        self.totalStudySessions = totalStudySessions
        self.totalBreakSessions = totalBreakSessions
        self.studySessionTime = studySessionTime
        self.breakSessionTime = breakSessionTime
    }
}
