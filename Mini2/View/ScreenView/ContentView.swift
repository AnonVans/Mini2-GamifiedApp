//
//  ContentView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 20/06/24.
//

import SwiftUI

struct ContentView: View {
    var hapticManager = HapticsManager()
    @State var signal = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
//            TimerComponent(signal: $signal)
//            
//            Button("Test Haptic") {
//                hapticManager.playStudyHaptics()
//            }
//            .buttonStyle(BorderedProminentButtonStyle())
//            
//            Button("Stop Haptic") {
//                hapticManager.stopStudyHaptics()
//            }
//            .buttonStyle(BorderedProminentButtonStyle())
        }
//        .padding()
//        .onChange(of: signal) { oldValue, newValue in
//            hapticManager.playStudyHaptics()
//        }
    }
}
