//
//  BeforeBreakView.swift
//  Mini2
//
//  Created by Jovanna Melissa on 22/06/24.
//

import SwiftUI

struct BeforeBreakView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemaining = 10.0
    @State private var yAmount = 575.0
    @State private var swipedUp = false
    
    @State private var studySignal = false
    @State var chicken: Chicken = Chicken()
    
    @Binding var sessionState: SessionState
    
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
                ZStack {
                    TimerComponent(currDuration: Int(timeRemaining), signal: $studySignal)
                        .onChange(of: studySignal) { oldValue, newValue in
                            sessionState = .LateToBreak
                        }
                        .offset(y: -25)
                    
                    VStack {
                        Image("arrowupnew")
                            .position(CGPoint(x: 200.0, y: yAmount))
                            .animation(.easeInOut(duration: 1), value: yAmount)
                            .gesture(
                                DragGesture(minimumDistance: 20, coordinateSpace: .global)
                                    .onEnded { value in
                                        let horizontalAmount = value.translation.width
                                        let verticalAmount = value.translation.height
                                        
                                        if abs(horizontalAmount) > abs(verticalAmount) {
                                            print(horizontalAmount < 0 ? "left swipe" : "right swipe")
                                        } else {
                                            print(verticalAmount < 0 ? "up swipe" : "down swipe")
                                            swipedUp = true
                                            sessionState = .EggCatch
                                        }
                                    })
                            .onReceive(timer) { input in
                                if timeRemaining > 0{
                                    timeRemaining -= 1
                                    
                                    if(yAmount >= 500.0){
                                        yAmount -= 100
                                    } else {
                                        yAmount = 575.0
                                    }
                                }
                            }
                            .offset(y: 25)
                        
                        Text("Swipe up to rest")
                            .font(.system(size: 27))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary6)
                            .padding(25)
                    }
                }
            }
        }
        .onAppear {
            chicken.state = .Happy
            chicken.pose = .HandsUp
        }
    }
}

//#Preview {
//    BeforeBreakView()
//}
