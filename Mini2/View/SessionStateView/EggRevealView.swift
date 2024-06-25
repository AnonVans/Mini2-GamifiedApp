//
//  EggRevealView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 25/06/24.
//

import SwiftUI

struct EggRevealView: View {
    var gachaVM = EggGachaViewModel.getInstance()
    @State var chicken: Chicken?
    @Binding var sessionState: SessionState
    
    var timeAssignVM = TimeAssignmentViewModel.getInstance()
    
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
            
            //compare userdefault chicken with gotten chicken
            CustomButton(type: .Solid, text: "Use")
                .onTapGesture {
                    gachaVM.updateChicken(chicken!)
                    timeAssignVM.updateSession()
                    sessionState = .BreakSession
                }
            
            CustomButton(type: .Outline, text: "Skip")
                .onTapGesture {
                    timeAssignVM.updateSession()
                    print(timeAssignVM.sessionDuration)
                    sessionState = .BreakSession
                }
            
            Spacer()
        }
        .onAppear {
//            chicken = gachaVM.gachaChicken()
        }
    }
}

//#Preview {
//    EggRevealView()
//}
