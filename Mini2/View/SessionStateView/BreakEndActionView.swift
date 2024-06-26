//
//  BreakSessionGameView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 22/06/24.
//

import SwiftUI

struct BreakEndActionView: View {
    @State var foxSize = 245.0
    @State var foxXPos = 25.0
    @State var messageXOffset = -125.0
    
    @State var timer: Timer?
    @State var limitCounter = 0
    @State var timerSignal: Bool = false
    @State var chicken: Chicken = Chicken()
    
    @Binding var sessionState: SessionState
    
    var body: some View {
        ZStack {
            Color.primaryBG
                .ignoresSafeArea()
            
            ZStack {
                HStack {
                    Image("Swiper")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(32))
                        .frame(width: foxSize)
                        .position(x: foxXPos, y: 350)
                        .onAppear {
                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                                limitCounter += 1
                                
                                withAnimation(.easeIn(duration: 1)) {
                                    foxXPos += 1
                                }
                                
                                withAnimation(.spring()) {
                                    foxSize += 6
                                    messageXOffset += 3
                                }
                            })
                        }
                        .onChange(of: limitCounter) { oldValue, newValue in
                            if limitCounter == 30 {
                                stopTimer()
                                sessionState = .BreakActivityFailed
                            }
                        }
                    
                    VStack(alignment: .leading) {
                        Text("Muehehehe!")
                            .fontWeight(.bold)
                        Text("I’m gonna steal your outfit")
                    }
                    .font(.system(size: 19))
                    .foregroundStyle(.red4)
                    .offset(x: messageXOffset)
                }
                
                Image(chicken.getChickenName())
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .position(x: 300, y: 575)
            }
                
            VStack {
                Text("Save your Chiki!")
                  .font(.system(size: 27))
                  .fontWeight(.semibold)
                  .foregroundColor(.primary6)
                  .frame(width: 250, alignment: .top)
                  .padding(.top, 35)
                
                TimerComponent(currDuration: 10, signal: $timerSignal, type: .Swiper)
                    .padding(1)
                
                Spacer()
                
                Image(systemName: "hand.tap")
                    .font(.system(size: 50))
                    .frame(width: 49, height: 65)
                    .foregroundStyle(.primary6)
                
                Text("Quick Tap Swiper!")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 0.19, green: 0.44, blue: 0.83))
                    .padding(.bottom, 25)
            }
            
        }
        .onAppear {
            chicken.state = .Scared
        }
        .onTapGesture {
            if foxSize < 195.0{
                stopTimer()
                sessionState = .BreakActivitySuccess
            } else {
                foxSize -= 10
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

struct BreakEndSuccessView: View {
    @State var chicken = Chicken(state: .Happy, pose: .HandsUp)
    @Binding var sessionState: SessionState
    
    var timeAssignVM = TimeAssignmentViewModel.getInstance()
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Yeay!")
                .font(.system(size: 27))
                .fontWeight(.bold)
                .foregroundColor(.primary6)
                .padding(.vertical, 5)
            
            Text("Your items are save from swiper.")
                .font(.system(size: 19))
                .frame(width: 212)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary5)

            Spacer()
            
            Image(chicken.getChickenName())
                .resizable()
                .scaledToFit()
                .frame(height: 315)
            
            Spacer(minLength: 200)
            
            Button(action: {
                timeAssignVM.updateSession()
                sessionState = .StudySession
            }, label: {
                HStack {
                    Text("Next")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary5)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary6)
                    
                }
            })
            .buttonStyle(PlainButtonStyle())
            .padding(10)
            
        }
    }
}

struct BreakEndFailedView: View {
    @State var chicken = Chicken(state: .Scared)
    @Binding var sessionState: SessionState
    
    var timeAssignVM = TimeAssignmentViewModel.getInstance()
    
    var body: some View {
        ZStack {
            Image(chicken.getChickenName())
                .resizable()
                .scaledToFit()
                .offset(y: -50)
            
            LinearGradient(
                colors: [.clear, .primaryBG],
                startPoint: UnitPoint(x: 0.48, y: 0),
                endPoint: UnitPoint(x: 0.48, y: 0.3)
            )
            .frame(height: 300)
            .offset(y: 75)
            
            VStack {
                Spacer()
                
                VStack {
                    Text("Foxy Stole My Skin!")
                        .font(.system(size: 33))
                        .fontWeight(.bold)
                        .foregroundColor(.red5)
                    
                    Text("Its okay, next time plis help me!")
                        .font(.system(size: 19))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red4)
                }
                .offset(y: 125)
                    
                Spacer()
                
                CustomButton(type: .Solid, width: 200.0, text: "Finish Studying")
                    .onTapGesture {
                        timeAssignVM.updateSession()
                        sessionState = .StudySession
                    }
                    .offset(y: -50)
            }
        }
    }
}

//#Preview {
//    BreakEndActionView()
//}
