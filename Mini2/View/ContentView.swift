//
//  ContentView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 20/06/24.
//

import SwiftUI

struct ContentView: View {
    @State var itemSignal = false
    @State var startSignal = false
    
    var body: some View {
        NavigationStack {
            SetTimerView(itemSignal: $itemSignal, startSignal: $startSignal)
                .navigationDestination(isPresented: $itemSignal) {
                    CollectableItemsView()
                }
                .navigationDestination(isPresented: $startSignal) {
                    StudySessionPageView()
                }
        }
    }
}

#Preview {
    ContentView()
}
