//
//  TimerComponent.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 22/06/24.
//

import SwiftUI

struct TimerComponent: View {
    @State var currDuration = 15
    @State var timer: Timer?
    @Binding var signal: Bool
    
    var type: TimerType = .Regular
    
    var body: some View {
        VStack {
            Text(String(format: "%02d:%02d", currDuration/60, currDuration%60))
//                .font(Font.custom("SF Pro Rounded", size: 128))
                .font(.system(size: type.rawValue == "Swipe" ? 33 : 48))
                .bold()
                .foregroundStyle(type.rawValue == "Swipe" ? .primary5 : (type.rawValue == "Break" ? .yellow7 : .primary6))
                .onAppear {
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                        if currDuration > 0 {
                            currDuration -= 1
                        }
                    })
                }
                .onChange(of: currDuration) { oldValue, newValue in
                    if currDuration == 0 {
                        timer?.invalidate()
                        timer = nil
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            signal = true
                        }
                    }
                }
        }
    }
}

//#Preview {
//    TimerComponent()
//}
