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
    var currentSession:Int
    var studyTime:Int
    var totalSession:Int
    @ObservedObject private var vm = TimeAssignmentViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .foregroundStyle(Color.primary1)
                    .ignoresSafeArea()
                
                VStack{
                    Text("Study Session \(currentSession) of \(totalSession)")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                    
                    Image("Ayam")
                        .padding(.top, 50)
                    
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
                        .fontWeight(.regular)
                        .font(.system(size: 56))
                        .padding(.top, 50)
                    
                    Text("time left")
                        .font(.system(size: 19))
                        .navigationDestination(isPresented: $sessionFinished){
                            BeforeBreakView(currentSession: currentSession, totalSession: totalSession)}
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear(perform: {
//            timeRemaining = studyTime * 60
        })
    }
}

#Preview {
    StudySessionTimerView(currentSession: 0, studyTime: 1, totalSession: 1)
}

extension StudySessionTimerView{
    func timeFormat(remainingTime: Int){
        let duration = Duration.seconds(timeRemaining)
        format = duration.formatted(
            .time(pattern: .minuteSecond))
    }
}
