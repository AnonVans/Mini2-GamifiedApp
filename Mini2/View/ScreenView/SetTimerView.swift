//
//  SetTimerView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 25/06/24.
//

import SwiftUI

struct SetTimerView: View {
    @Binding var itemSignal: Bool
    @Binding var startSignal: Bool
    
    @State var chick: Chicken = Chicken()
    
    var timeAssignVM = TimeAssignmentViewModel.getInstance()
    
    var body: some View {
        ZStack {
            Color.primaryBG
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    VStack(alignment: .center){
                        Image("Egg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        Text("Collected\nItems")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.primary5)
                    }
                    .padding(.trailing, 20)
                    .onTapGesture {
                        itemSignal.toggle()
                    }
                }
                Spacer()
            }
            
            VStack {
                Image(chick.getChickenName())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 175)
                
                Text("Start studying today!")
                    .font(.system(size: 27))
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary6)
                    .offset(y: 10)
                
                TimePickerComponent()
                
                CustomButton(type: .Solid, size: .Large, text: "Start")
                    .onTapGesture {
                        timeAssignVM.resetCurrentSession()
                        timeAssignVM.updateSession()
                        startSignal.toggle()
                    }
                    .padding(.top, 25)
            }
            .offset(y: 25)
        }
    }
}

//#Preview {
//    SetTimerView()
//}
