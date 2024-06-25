//
//  BreakSessionGameView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 22/06/24.
//

import SwiftUI

struct BreakEndActionView: View {
    @State var foxSize = 150.0
    @State var timer: Timer?
    @State var limitCounter = 0
    @State var timerSignal: Bool = false
    
    @Binding var sessionState: SessionState

    var body: some View {
        ZStack {
            Color.primaryBG
                .ignoresSafeArea()
            
            Rectangle()
                .frame(width: foxSize, height: foxSize)
                .foregroundStyle(.orange)
                .onAppear {
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                        limitCounter += 1
                        
                        withAnimation(.spring()) {
                            foxSize += 5
                        }
                    })
                }
                .onChange(of: limitCounter) { oldValue, newValue in
                    if limitCounter == 30 {
                        stopTimer()
                        sessionState = .BreakActivityFailed
                    }
                }
            
            VStack {
                Text("Save your chicken!")
                  .font(.system(size: 27))
                  .fontWeight(.semibold)
                  .foregroundColor(.primary6)
                  .frame(width: 250, alignment: .top)
                  .padding(.top, 35)
                
                TimerComponent(currDuration: 30, signal: $timerSignal, type: .Swiper)
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
        .onTapGesture {
            if foxSize < 50{
                stopTimer()
                sessionState = .BreakActivitySuccess
            } else {
                foxSize -= 15
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

struct BreakEndSuccessView: View {
    
    @Binding var sessionState: SessionState
    
    var body: some View {
        ZStack {
            VStack {
                
                
                Text("Good Job!")
                Text("Your items are safe from Swipper")
                
                CustomButton(width: 200, text: "Study Session")
            }
        }
    }
}

struct BreakEndFailedView: View {
    
    @Binding var sessionState: SessionState
    
    var body: some View {
        ZStack {
            VStack {
                
                
                Text("Failed!")
                Text("You failure")
                Text("ft. Steven He")
                
                CustomButton(width: 200, text: "Study Session")
            }
        }
    }
}

//#Preview {
//    BreakEndActionView()
//}
