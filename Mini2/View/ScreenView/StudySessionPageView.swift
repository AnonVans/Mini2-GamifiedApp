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
            
            if !timeAssignVM.sessionOver {
                switch sessionState {
                case .StudySession:
                    StudySessionTimerView(sessionState: $sessionState)
//                    EmptyView()
                case .StudyActivity:
                    BeforeBreakView(sessionState: $sessionState)
                        .onAppear {
                            hapticsManager.playStudyHaptics()
                        }
                        .onDisappear {
                            hapticsManager.stopStudyHaptics()
                        }
//                    EmptyView()
                case .EggCatch:
                    EggCatchView(sessionState: $sessionState)
//                    EmptyView()
                case .LateToBreak:
                    //Negative case
                    Text("Something")
                case .FailedToCatch:
                    //Negative case
                    Text("Something")
                case .ChooseEggs:
                    EggGachaView(sessionState: $sessionState)
//                    EmptyView()
                case .OpenEggs:
                    EggRevealView(sessionState: $sessionState)
//                    EmptyView()
                case .StartBreak:
                    StartBreakView(sessionState: $sessionState)
//                    EmptyView()
                case .BreakSession:
                    BreakSessionView(sessionState: $sessionState)
//                    EmptyView()
                case .BreakActivity:
                    BreakEndActionView(sessionState: $sessionState)
                        .onAppear {
                            hapticsManager.playBreakHaptics()
                        }
                        .onDisappear {
                            hapticsManager.stopBreakHaptics()
                        }
//                    EmptyView()
                case .BreakActivityFailed:
                    BreakEndFailedView(sessionState: $sessionState)
//                    EmptyView()
                case .BreakActivitySuccess:
                    BreakEndSuccessView(sessionState: $sessionState)
//                    EmptyView()
                }
            } else {
                CongratulationsView()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//#Preview {
//    StudySessionPageView()
//}
