//
//  ContentView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 20/06/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment (\.modelContext) var dataContext
    @Query(sort: \SkinsDataModel.id) var skinsData: [SkinsDataModel]
    
    @State var itemSignal = false
    @State var startSignal = false
    
    var gachaVM = EggGachaViewModel.getInstance()
    
    var body: some View {
        NavigationStack {
            SetTimerView(itemSignal: $itemSignal, startSignal: $startSignal)
                .navigationDestination(isPresented: $itemSignal) {
                    CollectableItemsView()
                }
                .navigationDestination(isPresented: $startSignal) {
                    StudySessionPageView(sessionState: .StudySession)
                }
        }
        .onAppear {
            let firstLaunch = UserDefaults.standard.bool(forKey: "FirstLaunch")
            if firstLaunch == false {
                UserViewModel.saveChick(Chicken())
                UserDefaults.standard.set(true, forKey: "FirstLaunch")
            }
            
            if skinsData.isEmpty {
                SkinsDataViewModel.populateModel(gachaVM.getChickens(), dataContext)
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
