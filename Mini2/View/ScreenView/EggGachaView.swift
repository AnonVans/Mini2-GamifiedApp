//
//  EggGachaView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 22/06/24.
//

import SwiftUI

struct EggGachaView: View {
    @State var gachaState: SessionState = .ChooseEggs
    @State var chosenEgg: String?
    
    //Make eggs array to iterate
    var eggs = ["1", "2", "3"]
    
    var body: some View {
        
        Text("Hello World")
        
//        switch gachaState {
//        case .ChooseEggs:
//            ChooseEggView(gachaState: $gachaState, prizeEgg: $chosenEgg, eggs: eggs)
//        case .OpenEggs:
//            EggRevealView(chosenGachaEgg: chosenEgg)
//        }
        
    }
}

struct ChooseEggView: View {
    @Binding var gachaState: SessionState
    @Binding var prizeEgg: String?
    
    var eggs = [String]()
    
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
                    ForEach(eggs, id: \.self) { egg in
                        Rectangle()
                            .frame(width: 75, height: 75)
                            .onTapGesture {
                                gachaState = .OpenEggs
                                prizeEgg = egg
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

struct EggRevealView: View {
    @State var chosenGachaEgg: String?
   
    var body: some View {
        VStack {
            Spacer()
            
            Text("Yeay!!")
                .font(.system(size: 40))
                .foregroundStyle(.primary6)
                .bold()
            
            Spacer()
            
            //Chicken Block
            
            Spacer()
            
            CustomButton(type: .Solid, text: "Use")
            CustomButton(type: .Outline, text: "Skip")
            
            Spacer()
        }
    }
}
#Preview {
    EggRevealView()
}
