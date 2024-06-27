//
//  StudySessionPageView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 25/06/24.
//

import SwiftUI

struct StudySessionPageView: View {
    @State var sessionState: SessionState = .StudySession
    @State var specialEvent = false
    
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
                case .StudyActivity:
                    BeforeBreakView(sessionState: $sessionState)
                        .onAppear {
                            hapticsManager.playStudyHaptics()
                        }
                        .onDisappear {
                            hapticsManager.stopStudyHaptics()
                        }
                case .EggCatch:
                    EggCatchView(sessionState: $sessionState)
                case .LateToBreak:
                    FailedToBreak(sessionState: $sessionState)
                case .FailedToCatch:
                    FailedToBreak(failedType: .FailCatch, sessionState: $sessionState)
                case .ChooseEggs:
                    EggGachaView(sessionState: $sessionState)
                case .OpenEggs:
                    EggRevealView(sessionState: $sessionState)
                case .StartBreak:
                    StartBreakView(sessionState: $sessionState)
                case .BreakSession:
                    BreakSessionView(sessionState: $sessionState)
                case .BreakActivity:
                    BreakEndActionView(sessionState: $sessionState)
                        .onAppear {
                            hapticsManager.playBreakHaptics()
                        }
                        .onDisappear {
                            hapticsManager.stopBreakHaptics()
                        }
                case .BreakActivityFailed:
                    BreakEndFailedView(sessionState: $sessionState)
                case .BreakActivitySuccess:
                    BreakEndSuccessView(sessionState: $sessionState)
                }
            } else {
                if specialEvent {
                    SpecialLaunchView()
                } else {
                    CongratulationsView(specialEvent: $specialEvent)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//#Preview {
//    StudySessionPageView()
//}
