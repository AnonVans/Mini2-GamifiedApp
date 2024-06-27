//
//  WalkingChicken.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 26/06/24.
//

import SwiftUI

struct WalkingChicken: View {
    @State private var chickenLeft = true
    @State private var chickenDirection = "DefaultNormalLookLeft"
    
    @State var chicken: Chicken = UserViewModel.readChick()
    @State var walkState = 0
    @State private var chick1XPos = 200.0
    @State private var chick2XPos = 445.0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            if walkState < 4 {
                Image(chicken.getChickenName())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 245)
                    .position(CGPoint(x: chick1XPos, y: 200.0))
                    .padding(.top, 100)
            }
            
            if walkState > 1 {
                Image(chicken.getChickenName())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 245)
                    .position(CGPoint(x: chick2XPos, y: 200.0))
                    .padding(.top, 100)
            }
        }
        .onReceive(timer) { input in
            if walkState == 6 {
                walkState = 0
            } else{
                walkState += 1
            }
            
            switch walkState {
                case 1:
                    chick1XPos = 125.0
                case 2:
                    chick1XPos = 50.0
                    chick2XPos = 445.0
                case 3:
                    chick1XPos = -25.0
                    chick2XPos = 370.0
                case 4:
                    chick2XPos = 295.0
                case 5:
                    chick2XPos = 200.0
                case 6:
                    chicken.pose = .LookRight
                default:
                    chicken.pose = .LookLeft
                    chick1XPos = 200.0
            }
        }
    }
}

#Preview {
    WalkingChicken()
}
