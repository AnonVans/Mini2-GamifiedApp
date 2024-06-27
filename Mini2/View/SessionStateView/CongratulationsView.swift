//
//  CongratulationsView.swift
//  Mini2
//
//  Created by Venussha Loveita Joyce Chandra on 24/06/24.
//

import SwiftUI
import SwiftData

struct CongratulationsView: View {
    @Environment (\.modelContext) var dataContext
    @Query(sort: \SkinsDataModel.id) var skinsData: [SkinsDataModel]
    
    @Environment(\.dismiss) var dismiss
    @State var chicken = UserViewModel.readChick()
    @State var specialPrize = false
    @Binding var specialEvent: Bool
    
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
                
                CustomButton(type: .Solid, width: 200.0, text: specialPrize ? "Claim Reward" : "Back to Timer")
                    .onTapGesture {
                        if specialPrize {
                            specialEvent = true
                        } else {
                            timeAssignVM.resetCurrentSession()
                            dismiss()
                        }
                    }
                    .offset(y: -50)
            }
        }
        .onAppear {
            chicken.state = .Happy
            chicken.pose = .HandsUp
            
            let chickens = SkinsDataViewModel.fetchItems(skinsData, dataContext)
            specialPrize = chickens.last?.locked ?? false
        }
    }
}

//#Preview {
//    CongratulationsView()
//}
