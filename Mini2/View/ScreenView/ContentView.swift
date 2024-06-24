//
//  ContentView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 20/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentStudySession = 0
    @State private var currentBreakSession = 0
    var totalStudySession:Int
    var totalBreakSession:Int
    var studySessionTime:[Int]
    var breakSessionTime:[Int]
    var currentSession:String
    
    var body: some View {
        if(self.assignView() == "study"){
            StudySessionTimerView(currentSession: 0, studyTime: 1, totalSession: 1)
                .onAppear(perform: {
                    currentStudySession+=1
                })
        } else if(self.assignView() == "break"){
            BreakTimerView()
        }
    }
}

extension ContentView{
    func assignView()->String{
        if(currentSession == "break" && currentStudySession <= totalStudySession){
//            currentStudySession += 1
            return "study"
        } else if(currentSession == "study" && currentBreakSession <= totalBreakSession){
            currentBreakSession += 1
            return "break"
        }
        
        return ""
    }
}
