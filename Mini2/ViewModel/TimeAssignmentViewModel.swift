//
//  ContentViewController.swift
//  Mini2
//
//  Created by Jovanna Melissa on 23/06/24.
//

import Foundation
import SwiftData
import SwiftUI

class TimeAssignmentViewModel: ObservableObject {
    @Published var studySessionTotal: Int = 2
    @Published var breakSessionTotal: Int = 1
    @Published var studyTimeinMinutes = 60
    @Published var currentSession = 0
    @Published var totalSession = 3
    
    @Published var sessionOver = false
    var sessionDuration = 5
    
    private static var timeAssignVM: TimeAssignmentViewModel?
    
    static func getInstance() -> TimeAssignmentViewModel {
        if self.timeAssignVM == nil {
            timeAssignVM = TimeAssignmentViewModel()
        }
        return self.timeAssignVM!
    }
    
    func timeAssignment(_ studyTime:Int){
        self.studyTimeinMinutes = studyTime * 60
        self.studySessionTotal = studyTimeinMinutes/30
        self.breakSessionTotal = studySessionTotal - 1
        self.totalSession = self.studySessionTotal + self.breakSessionTotal
        
        print("Study time: \(studyTimeinMinutes)")
        print("Study session: \(studySessionTotal)")
        print("Break session: \(breakSessionTotal)")
    }
    
    func getStudySession() -> Int {
        if currentSession%2 != 0 {
            return (currentSession + 1) / 2
        } else {
            return currentSession / 2
        }
    }
    
    func getBreakSession() -> Int {
        if currentSession%2 != 0 {
            return (currentSession - 1) / 2
        } else {
            return currentSession / 2
        }
    }
    
    func updateSession() {
        self.currentSession += 1
        calculateSessionDuration()
        print("Session: \(self.currentSession) || Remaining: \(self.studyTimeinMinutes)")
    }
    
    func checkEndSession() {
        if self.studyTimeinMinutes == 0 {
            self.sessionOver = true
        }
    }
    
    func calculateSessionDuration() {
        if currentSession%2 == 1 {
            //Return Study Session
            if self.studyTimeinMinutes > 30 {
                self.studyTimeinMinutes -= 25
                print("25 Minute Study")
                self.sessionDuration = 10
            } else {
                self.studyTimeinMinutes = 0
                print("Irregular Minute Study")
                self.sessionDuration = 10
            }
        } else {
            //Return Break Session
            let currBreak = getBreakSession()
            if currBreak%4 == 0 {
                self.studyTimeinMinutes -= 15
                print("15 Minute Break")
                self.sessionDuration = 10
            } else {
                self.studyTimeinMinutes -= 5
                print("5 Minute Break")
                self.sessionDuration = 10
            }
        }
    }
    
    func resetCurrentSession() {
        if self.studyTimeinMinutes == 0 {
            self.studyTimeinMinutes = 60
        }
        
        self.currentSession = 0
        self.sessionOver = false
    }
}
