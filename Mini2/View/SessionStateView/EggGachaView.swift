//
//  EggGachaView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 22/06/24.
//

import SwiftUI

struct EggGachaView: View {
    var gachaVM = EggGachaViewModel.getInstance()
    
    @Binding var sessionState: SessionState
    
    var body: some View {
        
        ZStack {
            Color.primaryBG
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                HStack {
                    VStack {
                        Text("Thank you\nfor saving the egg.\nGuest what")
                            .font(.system(size: 17))
                            .foregroundStyle(.primary5)
                            .frame(width: 154, alignment: .topLeading)
                        
                        Text("It's yours!")
                            .font(.system(size: 27, weight: .semibold))
                            .foregroundStyle(.primary6)
                            .frame(width: 154, alignment: .topLeading)
                    }
                    
                    Rectangle()
                        .frame(width: 160, height: 190)
                }
                    
                Spacer()
                
                HStack {
                    ForEach(Array(1...gachaVM.getEggAmount()), id: \.self) { egg in
                        Rectangle()
                            .frame(width: 75, height: 75)
                            .onTapGesture {
                                sessionState = .OpenEggs
                            }
                    }
                }
                    
                Text("Choose one and get new skin")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.primary5)
                
                Spacer()
            }
        }
    }
}

//#Preview {
//    EggGachaView()
//}
