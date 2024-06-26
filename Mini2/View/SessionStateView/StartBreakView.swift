//
//  StartBreakView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 26/06/24.
//

import SwiftUI

struct StartBreakView: View {
    @Binding var sessionState: SessionState
    @State var chicken = Chicken()
    
    var timeAssignVM = TimeAssignmentViewModel.getInstance()
    
    var body: some View {
        ZStack {
            Image(chicken.getChickenName())
                .resizable()
                .scaledToFit()
                .offset(y: -50)
            
            LinearGradient(
                colors: [.clear, .primaryBG],
                startPoint: UnitPoint(x: 0.48, y: 0),
                endPoint: UnitPoint(x: 0.48, y: 0.3)
            )
            .frame(height: 300)
            .offset(y: 75)
            
            VStack {
                Spacer()
                
                VStack {
                    Text("Congratulations!")
                        .font(.system(size: 33))
                        .fontWeight(.bold)
                        .foregroundColor(.primary6)
                    
                    Text("you have successfully completed one stage of your session !")
                        .font(.system(size: 19))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary5)
                        .frame(width: 212, alignment: .top)
                }
                .offset(y: 125)
                    
                Spacer()
                
                CustomButton(type: .Solid, width: 200.0, text: "Start Break Time")
                    .onTapGesture {
                        timeAssignVM.updateSession()
                        print(timeAssignVM.sessionDuration)
                        sessionState = .BreakSession
                    }
                    .offset(y: -50)
            }
        }
        .onAppear {
            chicken.state = .Happy
            chicken.pose = .HandsUp
        }
    }
}

//#Preview {
//    StartBreakView()
//}
