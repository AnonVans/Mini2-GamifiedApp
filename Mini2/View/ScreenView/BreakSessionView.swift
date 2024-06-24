//
//  BreakSessionView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 22/06/24.
//

import SwiftUI

struct BreakSessionView: View {
    @State var timerSignal = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Have a nice break!")
                        .font(.system(size: 40))
                        .bold()
                    
                    TimerComponent(currDuration: 5, signal: $timerSignal)
                    
                    
                }
            }
            .navigationDestination(isPresented: $timerSignal) {
                BreakEndActionView(state: .Activity)
            }
        }
    }
}

#Preview {
    BreakSessionView()
}
