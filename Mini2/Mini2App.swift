//
//  Mini2App.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 20/06/24.
//

import SwiftUI
import SwiftData

@main
struct Mini2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
        .modelContainer(for: [
            SkinsDataModel.self
        ])
    }
}
