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
    @State private var timeRemaining = 10
    @State private var format = "0:0"
    @State private var sessionFinished = false
    @ObservedObject private var vm = TimeAssignmentViewModel()
    @State private var chickenXPosition = 200.0
    @State private var chickenLeft = true
    @State private var chickenDirection = "Ayam"
    
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .foregroundStyle(Color.primary1)
                    .ignoresSafeArea()
                
                VStack{
                    
                    Text("Study Time!")
                        .font(.system(size: 27))
                        .fontWeight(.semibold)
                        .padding(.top, 100)
                    
                    Image(chickenDirection)
                        .position(CGPoint(x: chickenXPosition, y: 50.0))
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
                    
                    Text("\(format)")
                        .onReceive(timer) { input in
                            if timeRemaining > 0{
                                timeRemaining -= 1
                            } else if(timeRemaining == 0){
                                sessionFinished = true
                                vm.currentStudySession += 1
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
                        .padding(.top, -300)
                    
                    Text("time left")
                        .font(.system(size: 19))
                        .padding(.top, -270)
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    StudySessionTimerView()
}

extension StudySessionTimerView{
    func timeFormat(remainingTime: Int){
        let duration = Duration.seconds(timeRemaining)
        format = duration.formatted(
            .time(pattern: .minuteSecond))
    }
    
    func addGradient(){
        
    }
}
