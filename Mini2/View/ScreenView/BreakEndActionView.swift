//
//  BreakSessionGameView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 22/06/24.
//

import SwiftUI

enum BreakState {
    case Activity
    case ActivitySuccess
    case ActivityFailed
}

struct BreakEndActionView: View {
    @State var state: BreakState = .Activity
    
    var body: some View {
        ZStack {
            Color.primaryBG
                .ignoresSafeArea()
            
            switch state {
            case .Activity:
                BreakOverActivity(signal: $state)
            case .ActivitySuccess:
                BreakEndSuccessView()
            case .ActivityFailed:
                BreakEndFailedView()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct BreakOverActivity: View {
    @State var foxSize = 150.0
    @State var timer: Timer?
    @State var limitCounter = 0
    @Binding var signal: BreakState
    
    var body: some View {
        ZStack {
            Color.primaryBG
                .ignoresSafeArea()
            
            Rectangle()
                .frame(width: foxSize, height: foxSize)
                .foregroundStyle(.orange)
                .onAppear {
                    timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { _ in
                        limitCounter += 1
                        
                        withAnimation(.spring()) {
                            foxSize += 10
                        }
                    })
                }
                .onChange(of: foxSize) { oldValue, newValue in
                    if limitCounter == 30 {
                        stopTimer()
                        signal = .ActivityFailed
                    }
                }
            
//            Circle()
//                .frame(width: 150, height: 150)
//                .foregroundStyle(.yellow5)
//                .offset(y: 75)
        }
        .onTapGesture {
            if foxSize < 50{
                stopTimer()
                signal = .ActivitySuccess
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

#Preview {
    BreakEndActionView()
}
