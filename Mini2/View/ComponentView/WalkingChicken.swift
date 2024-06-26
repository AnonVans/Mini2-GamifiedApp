//
//  WalkingChicken.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 26/06/24.
//

import SwiftUI

struct WalkingChicken: View {
    @State private var chickenXPosition = 200.0
    @State private var chickenLeft = true
    @State private var chickenDirection = "DefaultNormalLookLeft"
    
    @State var chicken: Chicken = Chicken()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Image(chicken.getChickenName())
            .position(CGPoint(x: chickenXPosition, y: 200.0))
            .padding(.top, 100)
            .onReceive(timer) { input in
                if(chickenXPosition > 10 && chickenLeft){
                    chickenXPosition -= 25
                } else if(chickenXPosition == 400) {
                    chickenLeft = true
                    chicken.pose = .LookLeft
                } else {
                    chickenLeft = false
                    chicken.pose = .LookRight
                    chickenXPosition += 25
                }
            }
    }
}

#Preview {
    WalkingChicken()
}
