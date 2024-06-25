//
//  StudySessionPageView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 25/06/24.
//

import SwiftUI

struct StudySessionPageView: View {
    @State var sessionState: SessionState = .StudySession
    
    var timeAssignVM = TimeAssignmentViewModel.getInstance()
    var hapticsManager = HapticsManager.getIntance()
    
    var body: some View {
        ZStack {
            Color.primaryBG
                .ignoresSafeArea()
            
            switch sessionState {
            case .StudySession:
                StudySessionTimerView(sessionState: $sessionState)
                    .onAppear {
                        timeAssignVM.updateSession()
                    }
            case .StudyActivity:
                BeforeBreakView(sessionState: $sessionState)
                    .onAppear {
                        hapticsManager.playStudyHaptics()
                    }
            case .EggCatch:
                //Not Added
                EmptyView()
            case .LateToBreak:
                //Negative case
                Text("Something")
            case .FailedToCatch:
                //Negative case
                Text("Something")
            case .ChooseEggs:
                EggGachaView(sessionState: $sessionState)
            case .OpenEggs:
                EggRevealView(sessionState: $sessionState)
            case .BreakSession:
                BreakSessionView(sessionState: $sessionState)
                    .onAppear {
                        timeAssignVM.updateSession()
                    }
            case .BreakActivity:
                BreakEndActionView(sessionState: $sessionState)
                    .onAppear {
                        hapticsManager.playBreakHaptics()
                    }
            case .BreakActivityFailed:
                BreakEndFailedView(sessionState: $sessionState)
            case .BreakActivitySuccess:
                BreakEndSuccessView(sessionState: $sessionState)
            }
        }
    }
}

#Preview {
    StudySessionPageView()
}
