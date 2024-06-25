//
//  BeforeBreakView.swift
//  Mini2
//
//  Created by Jovanna Melissa on 22/06/24.
//

import SwiftUI

struct BeforeBreakView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let eggTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var timeRemaining = 10.0
    @State private var format = "0:0"
    @State private var yAmount = 200.0
    @State private var swipedUp = false
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .foregroundStyle(Color.primary1)
                    .ignoresSafeArea()
                
                VStack{
                        Image("Ayam")
                            .padding(.top, 50)
                        
                        Text("\(format)")
                            .onReceive(timer) { input in
                                if timeRemaining > 0{
                                    timeRemaining -= 1
                                    
                                    if(yAmount >= 100.0){
                                        yAmount -= 150
                                    } else {
                                        yAmount = 200.0
                                    }
                                }
                            }
                            .onAppear(perform: {
                                timeFormat(remainingTime: timeRemaining)
                            })
                            .onChange(of: timeRemaining){
                                timeFormat(remainingTime:timeRemaining)
                            }
                            .fontWeight(.bold)
                            .font(.system(size: 48))
                            
                        Image("arrowupnew")
                            .position(CGPoint(x: 200.0, y: yAmount))
                            .animation(.easeInOut(duration: 1), value: yAmount)
                            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                                        .onEnded { value in
                                            let horizontalAmount = value.translation.width
                                            let verticalAmount = value.translation.height
                                            
                                            if abs(horizontalAmount) > abs(verticalAmount) {
                                                print(horizontalAmount < 0 ? "left swipe" : "right swipe")
                                            } else {
                                                print(verticalAmount < 0 ? "up swipe" : "down swipe")
                                                swipedUp = true
                                            }
                                        })
                        
                        Text("Swipe up to rest")
                            .fontWeight(.regular)
                            .font(.system(size: 27))
                            .padding(.bottom, 80)
                    }
                }
            }
    }
}

#Preview {
    BeforeBreakView()
}

extension BeforeBreakView{
    func timeFormat(remainingTime: TimeInterval){
        let duration = Duration.seconds(timeRemaining)
        format = duration.formatted(
            .time(pattern: .minuteSecond))
    }
}
