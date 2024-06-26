//
//  StudySessionTimerView.swift
//  Mini2
//
//  Created by Jovanna Melissa on 22/06/24.
//

import SwiftUI
import SwiftData

struct StudySessionTimerView: View {
    @State private var studySignal = false
    @Binding var sessionState: SessionState
    @State var chicken: Chicken = Chicken()
    
    var timeAssignVM = TimeAssignmentViewModel.getInstance()
    
    var body: some View {
        ZStack {
            WalkingChicken(chicken: chicken)
            
            LinearGradient(
                colors: [.clear, .primaryBG],
                startPoint: UnitPoint(x: 0.48, y: 0),
                endPoint: UnitPoint(x: 0.48, y: 0.2)
            )
            .frame(height: 200)
            
            VStack {
                Text("Study Time!")
                    .font(.system(size: 27))
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary6)
                    .offset(y: 60)
                
                Spacer()
                
                VStack {
                    Spacer()
                    
                    VStack {
                        TimerComponent(
                            currDuration: timeAssignVM.sessionDuration,
                            signal: $studySignal
                        )
                        .onChange(of: studySignal) { oldValue, newValue in
                            timeAssignVM.checkEndSession()
                            sessionState = .StudyActivity
                        }
                        
                        Text("Study \(timeAssignVM.getStudySession()) of \(timeAssignVM.studySessionTotal)")
                            .font(.system(size: 27))
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary3)
                    }
                    .offset(y: 25)
                        
                    Spacer()
                    
                    Text("You know what?\nChicki has good time management, we will take a roosting break on time!")
                        .font(.system(size: 19))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary5)
                        .frame(width: 230, alignment: .top)
                        .offset(y: -100)
                }
                
                Spacer()
            }
        }
    }
}

//#Preview {
//    StudySessionTimerView()
//}
