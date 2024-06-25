//
//  StudySessionTimerView.swift
//  Mini2
//
//  Created by Jovanna Melissa on 22/06/24.
//

import SwiftUI
import SwiftData

struct StudySessionTimerView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var chickenXPosition = 200.0
    @State private var chickenLeft = true
    @State private var chickenDirection = "Ayam"
    @State private var studySignal = false
    private var timeAsignVM = TimeAssignmentViewModel.getInstance()
    
    var body: some View {
        ZStack {
            //Background
            Color.primaryBG
                .ignoresSafeArea()
            
            Image(chickenDirection)
                .position(CGPoint(x: chickenXPosition, y: 200.0))
                .padding(.top, 100)
                .onReceive(timer) { input in
                    if(chickenXPosition > 10 && chickenLeft){
                        chickenXPosition -= 10
                    } else if(chickenXPosition == 400) {
                        chickenLeft = true
                        chickenDirection = "Ayam"
                    } else {
                        chickenLeft = false
                        chickenDirection = "ayamKanan"
                        chickenXPosition += 10
                    }
                }
                .animation(.bouncy(duration: 1), value: chickenXPosition)
            
            LinearGradient(
                colors: [.clear, .primaryBG],
                startPoint: UnitPoint(x: 0.48, y: 0),
                endPoint: UnitPoint(x: 0.48, y: 0.25)
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
                    TimerComponent(
                        currDuration: timeAsignVM.getSessionDuration(),
                        signal: $studySignal
                    )
                    
                    Text("You know what?\nChickens have good time management, we will rest strict to schedule")
                        .font(Font.custom("SF Pro Rounded", size: 19))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary5)
                        .frame(width: 230, alignment: .top)
                }
                
                Spacer()
                
                //            Text("\(format)")
                //                .onReceive(timer) { input in
                //                    if timeRemaining > 0{
                //                        timeRemaining -= 1
                //                    } else if(timeRemaining == 0){
                //                        sessionFinished = true
                ////                                vm.currentStudySession += 1
                //                    }
                //                }
                //                .onAppear(perform: {
                //                    timeFormat(remainingTime: timeRemaining)
                //                })
                //                .onChange(of: timeRemaining){
                //                    timeFormat(remainingTime:timeRemaining)
                //                }
                //                .fontWeight(.bold)
                //                .font(.system(size: 48))
                //                .padding(.top, -300)
            }
        }
    }
}

#Preview {
    StudySessionTimerView()
}
