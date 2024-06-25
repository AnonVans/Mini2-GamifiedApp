//
//  BreakSessionView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 22/06/24.
//

import SwiftUI

struct BreakSessionView: View {
    @State var breakSignal = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                //Background
                Color.primaryBG
                    .ignoresSafeArea()
                
                //Chicken Image
                Rectangle()
                    .frame(width: 175, height: 190)
                    .offset(y: -50)
                
                LinearGradient(
                    colors: [.clear, .primaryBG],
                    startPoint: UnitPoint(x: 0.48, y: 0),
                    endPoint: UnitPoint(x: 0.48, y: 0.25)
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
                        TimerComponent(currDuration: 5, signal: $breakSignal)

                        
                        Text("You know what?\nChickens have good time management, we will rest strict to schedule")
                            .font(Font.custom("SF Pro Rounded", size: 19))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary5)
                            .frame(width: 230, alignment: .top)
                    }
                    .offset(y: 60)
                    
                    Spacer()
                }
            }
//            .navigationDestination(isPresented: $timerSignal) {
//                BreakEndActionView(state: .Activity)
//            }
        }
    }
}

#Preview {
    BreakSessionView()
}
