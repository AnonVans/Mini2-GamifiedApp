//
//  BreakSessionView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 22/06/24.
//

import SwiftUI

struct BreakSessionView: View {
    @State private var breakSignal = false
    var timeAssignVM = TimeAssignmentViewModel.getInstance()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Binding var sessionState: SessionState
    @State var chicken: Chicken = Chicken()
    
    var body: some View {
        ZStack {
            //Background
            Color.primaryBG
                .ignoresSafeArea()
            
            //Chicken Image
            WalkingChicken(chicken: chicken)
            
            LinearGradient(
                colors: [.clear, .primaryBG],
                startPoint: UnitPoint(x: 0.48, y: 0),
                endPoint: UnitPoint(x: 0.48, y: 0.2)
            )
            .frame(height: 200)
            
            VStack {
                Text("Break Time!")
                    .font(.system(size: 27))
                    .fontWeight(.semibold)
                    .foregroundStyle(.yellow7)
                    .offset(y: 60)
                
                Spacer()
                
                VStack {
                    Spacer()
                    
                    VStack {
                        TimerComponent(
                            currDuration: timeAssignVM.sessionDuration,
                            signal: $breakSignal,
                            type: .Break
                        )
                        .onChange(of: breakSignal) { oldValue, newValue in
                            sessionState = .BreakActivity
                        }
                        
                        Text("Break \(timeAssignVM.getBreakSession()) of \(timeAssignVM.breakSessionTotal)")
                            .font(.system(size: 27))
                            .fontWeight(.semibold)
                            .foregroundStyle(.yellow6)
                    }
                    .offset(y: 25)
                    
                    Spacer()
                    
                    Text("You know what?\nChickens have good time management, we will rest strict to schedule")
                        .font(.system(size: 19))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.yellow6)
                        .frame(width: 230, alignment: .top)
                        .offset(y: -100)
                }
                
                Spacer()
            }
        }
    }
}

//#Preview {
//    BreakSessionView()
//}
