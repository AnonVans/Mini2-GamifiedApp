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
    
    var timeAssignVM = TimeAssignmentViewModel.getInstance()
    
    var body: some View {
        ZStack {
            Color.primaryBG
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    VStack(alignment: .center){
                        Image("telur collected items")
                        Text("Collected")
                        Text("Items")
                    }
                    .padding(.trailing, 20)
                    .onTapGesture {
                        itemSignal.toggle()
                    }
                }
                
                Image("ayam trial")
                    .resizable()
                    .foregroundColor(.blue)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 142)
                
                Text("Start studying today!")
                    .font(.system(size: 24))
                
                
                TimePickerComponent()
                
                Button {
                    print("Button pressed")
                } label: {
                    CustomButton(type: .Solid, size: .Large, text: "Start")
                        .onTapGesture {
                            timeAssignVM.resetCurrentSession()
                            timeAssignVM.updateSession()
                            startSignal.toggle()
                        }
                }
            }
        }
    }
}

//#Preview {
//    SetTimerView()
//}
