//
//  CongratulationsView.swift
//  Mini2
//
//  Created by Venussha Loveita Joyce Chandra on 24/06/24.
//

import SwiftUI

struct CongratulationsView: View {
    @Environment(\.dismiss) var dismiss
    @State var chicken = Chicken(state: .Happy, pose: .HandsUp)
    
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
                    
                    Text("You have made it to the end!")
                        .font(.system(size: 19))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary5)
                }
                .offset(y: 125)
                    
                Spacer()
                
                CustomButton(type: .Solid, width: 200.0, text: "Back to Timer")
                    .onTapGesture {
                        dismiss()
                    }
                    .offset(y: -50)
            }
        }
    }
}

#Preview {
    CongratulationsView()
}
