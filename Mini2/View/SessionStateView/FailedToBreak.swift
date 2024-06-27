//
//  FailedToBreak.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 26/06/24.
//

import SwiftUI

struct FailedToBreak: View {
    @State var failedType: WarningType = .FailBreak
    @State var chick: Chicken = UserViewModel.readChick()

    @Binding var sessionState: SessionState
    
    var timeAssignVM = TimeAssignmentViewModel.getInstance()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                HStack {
                    VStack {
                        Text(failedType.rawValue == -1 ? "Oh no...\nThe eggs are all\nbroken" : "Oh no...\nYou missed all the\neggs" )
                            .font(.system(size: 19))
                            .foregroundStyle(.red4)
                            .frame(width: 154, alignment: .topLeading)
                            .padding(.vertical, 1.5)
                        
                        Text(failedType.rawValue == -1 ? "You studied too long!" : "Try again next time!")
                            .font(.system(size: 27, weight: .semibold))
                            .foregroundStyle(.red5)
                            .frame(width: 154, alignment: .topLeading)
                            .padding(.vertical, 1.5)
                    }
                    
                    Image(chick.getChickenName())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 190)
                }
                    
                Spacer()
                
                Image("TelorBelahDua")
                    .offset(y: -25)
                    
                CustomButton(type: .Solid, width: 220.0, text: "Start Break Session")
                    .onTapGesture {
                        timeAssignVM.updateSession()
                        sessionState = .BreakSession
                    }
                
                Spacer()
            }
        }
        .onAppear {
            chick.state = .Scared
        }
    }
}

//#Preview {
//    FailedToBreak()
//}
