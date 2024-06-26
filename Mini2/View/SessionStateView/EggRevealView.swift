//
//  EggRevealView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 25/06/24.
//

import SwiftUI

struct EggRevealView: View {
    var gachaVM = EggGachaViewModel.getInstance()
    @State var chicken: Chicken = Chicken()
    @Binding var sessionState: SessionState
    
    var body: some View {
        VStack {
            Text("Yeay!!")
                .font(.system(size: 40))
                .foregroundStyle(.primary6)
                .bold()
                .padding(.top, 25)
            
            Text(chicken.skin.rawValue)
                .font(.system(size: 27))
                .fontWeight(.semibold)
                .foregroundStyle(.primary5)
                .padding(.vertical, 25)
            
            ZStack {
                Image(chicken.getChickenName())
                    .resizable()
                    .scaledToFit()
                    .frame(height: 225)
                    .offset(x: 15)
                
                Image("TelorBelahDua")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 360)
                    .offset(x: 1, y: 140)
            }
            
            Spacer()
            
            VStack {
                //compare userdefault chicken with gotten chicken
                CustomButton(type: .Solid, text: "Use")
                    .onTapGesture {
                        gachaVM.updateChicken(chicken)
                            sessionState = .StartBreak
                    }
                
                CustomButton(type: .Outline, text: "Keep Skin")
                    .onTapGesture {
                            sessionState = .StartBreak
                    }
                    .padding(.top, 15)
            }
            .offset(y: 50)
            
            Spacer()
        }
        .onAppear {
            chicken = gachaVM.gachaChicken()
        }
    }
}

//#Preview {
//    EggRevealView()
//}
