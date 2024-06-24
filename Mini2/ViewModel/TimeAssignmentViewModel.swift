//
//  ContentViewController.swift
//  Mini2
//
//  Created by Jovanna Melissa on 23/06/24.
//

import Foundation
import SwiftData
import SwiftUI

class TimeAssignmentViewModel:ObservableObject{
    @Published var studySessionTotal:Int = 0
    @Published var breakSessionTotal:Int = 0
    @Published var studySessionTime:[Int] = []
    @Published var breakSessionTime:[Int] = []
    @Published var studyTimeinSeconds = 0
    @Published var currentStudySession = 1
    
    func timeAssignment(studyTime:Int){
        var studyTimeinMinutes = studyTime * 60
        print(studyTimeinMinutes)
        
        self.studySessionTotal = studyTimeinMinutes/30
        self.breakSessionTotal = studySessionTotal - 1
        
        print(studySessionTotal)
        print(breakSessionTotal)
        
        studySessionTime = [25]
        studyTimeinMinutes -= 25
        
        breakSessionTime = [5]
        studyTimeinMinutes -= 5
        
        var breakSessionCounter = 2
        while(studyTimeinMinutes>0){
            if(studyTimeinMinutes >= 25 && studyTimeinMinutes != 30){
                studySessionTime.append(25)
                studyTimeinMinutes -= 25
                
                if(breakSessionTotal >= 2 && breakSessionCounter <= breakSessionTotal && (breakSessionCounter%4 != 0)){
                    breakSessionTime.append(5)
                    studyTimeinMinutes -= 5
                } else {
                    breakSessionTime.append(15)
                    studyTimeinMinutes -= 15
                }
                breakSessionCounter += 1
            } else if(studyTimeinMinutes == 30){
                studySessionTime.append(30)
                studyTimeinMinutes -= 30
            } else {
                studySessionTime.append(studyTimeinMinutes)
                studyTimeinMinutes = 0
            }
        }
        
        print(studySessionTime)
        print(breakSessionTime)
    }
}
