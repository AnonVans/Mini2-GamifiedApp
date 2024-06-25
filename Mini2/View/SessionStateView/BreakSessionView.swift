//
//  BreakSessionView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 22/06/24.
//

import SwiftUI

struct BreakSessionView: View {
    @State private var chickenXPosition = 200.0
    @State private var chickenLeft = true
    @State private var chickenDirection = "Ayam"
    @State private var breakSignal = false
    var timeAssingVM = TimeAssignmentViewModel.getInstance()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Binding var sessionState: SessionState
    
    var body: some View {
        NavigationStack {
            ZStack {
                //Background
                Color.primaryBG
                    .ignoresSafeArea()
                
                //Chicken Image
                Image("Ayam")
                    .position(CGPoint(x: chickenXPosition, y: 200.0))
                    .padding(.top, 100)
                    .onReceive(timer) { input in
                        if(chickenXPosition > 10 && chickenLeft){
                            chickenXPosition -= 25
                        } else if(chickenXPosition == 400) {
                            chickenLeft = true
                            chickenDirection = "Ayam"
                        } else {
                            chickenLeft = false
                            chickenDirection = "ayamKanan"
                            chickenXPosition += 25
                        }
                    }
                
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
                        .foregroundStyle(.primary6)
                        .offset(y: 60)
                    
                    Spacer()
                    
                    VStack {
                        TimerComponent(
                            currDuration: timeAssingVM.getSessionDuration(),
                            signal: $breakSignal
                        )
                        .onChange(of: breakSignal) { oldValue, newValue in
                            sessionState = .BreakActivity
                        }

                        Text("You know what?\nChickens have good time management, we will rest strict to schedule")
                            .font(Font.custom("SF Pro Rounded", size: 19))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary5)
                            .frame(width: 230, alignment: .top)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

//#Preview {
//    BreakSessionView()
//}
