//
//  TimeAssignmentView.swift
//  Mini2
//
//  Created by Jovanna Melissa on 23/06/24.
//

import SwiftUI

struct TimeAssignmentView: View {
    var studyTime:Int
    @ObservedObject private var vm = TimeAssignmentViewModel()
    
    var body: some View {
        NavigationStack{
            Text("Hello world")
            Text("Total study sessions: \(vm.studySessionTotal)")
            Text("Study sessions time:")
            ForEach(Array(0..<vm.studySessionTime.count), id:\.self){i in
                Text("studytime: \(vm.studySessionTime[i])")
            }
            Text("Total break sessions: \(vm.breakSessionTotal)")
            Text("Break sessions time:")
            ForEach(Array(0..<vm.breakSessionTime.count), id:\.self){j in
                Text("breaktime: \(vm.breakSessionTime[j])")
            }
            
            NavigationLink{
                StudySessionTimerView(currentSession: vm.currentStudySession, studyTime: 25, totalSession: vm.studySessionTotal)
            } label: {
                CustomButton(type: .Solid, size: .Medium, text: "Start")
            }
        }
        .onAppear(perform: {
            vm.timeAssignment(studyTime: studyTime)
        })
    }
}

#Preview {
    TimeAssignmentView(studyTime: 2)
}
