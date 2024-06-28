//
//  ChickenRevealView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 27/06/24.
//

import SwiftUI

struct ChickenRevealView: View {
    var skinName = "DetectiveNormalLookLeft"
    var type: EggRevealType = .Regular
    
    @State var state = 0
    @State var chickSize = 165.0
    @State var showChick = false
    
    @Binding var showAll: Bool
    
    var body: some View {
        ZStack {
            if showChick {
                Image(skinName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: chickSize)
                    .offset(x: 15)
            }
            
            switch state {
                case 0:
                    Image(type == .SpecialLaunch ? "SpecialEggWhole" : "Egg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                case 1:
                    Image(type == .SpecialLaunch ? "SpecialEggCrack" : "TelorPecah")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                default:
                    Image(type == .SpecialLaunch ? "SpecialEggBreak" : "TelorBelahDua")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 360)
                        .offset(x: 1, y: 140)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.snappy(duration: 1)) {
                    showChick = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.snappy(duration: 2)) {
                    state += 1
                } completion: {
                    withAnimation(.snappy(duration: 2)) {
                        chickSize = 225
                        state += 1
                    } completion: {
                        showAll = true
                    }
                }
            }
        }
    }
}

//#Preview {
//    ChickenRevealView()
//}
