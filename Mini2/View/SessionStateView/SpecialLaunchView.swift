//
//  SpecialLaunchView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 27/06/24.
//

import SwiftUI

struct SpecialLaunchView: View {
    @Environment(\.dismiss) var dismiss
    @State var chicken: Chicken = Chicken()

    var timeAssignVM = TimeAssignmentViewModel.getInstance()
    var gachaVM = EggGachaViewModel.getInstance()
    
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
                
                Image("SpecialEggBreak")
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
                        timeAssignVM.resetCurrentSession()
                        dismiss()
                    }
                
                CustomButton(type: .Outline, text: "Save")
                    .onTapGesture {
                        timeAssignVM.resetCurrentSession()
                        dismiss()
                    }
                    .padding(.top, 15)
            }
            .offset(y: 50)
            
            Spacer()
        }
        .onAppear {
            let chickens = gachaVM.getChickens()
            chicken = chickens.last?.chicken ?? Chicken()
            
            chicken.state = .Happy
            chicken.pose = .HandsUp
        }
    }
}

#Preview {
    SpecialLaunchView()
}
