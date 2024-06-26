//
//  CollectableItemsView.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 26/06/24.
//

import SwiftUI

struct CollectableItemsView: View {
    @State var chicken: Chicken = Chicken()

    var gachaVM: EggGachaViewModel = EggGachaViewModel.getInstance()
    var columnLayout: [GridItem] = Array(repeating: GridItem(.fixed(70), spacing: 50, alignment: .center), count: 3)
    
    var body: some View {
        VStack {
            Image(chicken.getChickenName())
                .resizable()
                .scaledToFit()
                .frame(height: 195)
                .padding(.top, 50)
            
            Spacer()
            
            VStack {
                ScrollView {
                    LazyVGrid(columns: columnLayout) {
                        ForEach(gachaVM.getChickens(), id: \.self) { chick in
                            VStack {
                                ZStack {
                                    if chick.locked {
                                        Color.black
                                            .frame(width: 90, height: 105)
                                            .mask {
                                                Image(chick.chicken.getChickenName())
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 90)
                                            }
                                    } else {
                                        Image(chick.chicken.getChickenName())
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 90)
                                    }
                                    
                                    if chick.chicken == chicken {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 30))
                                            .foregroundStyle(.primary5)
                                            .background {
                                                Circle()
                                                    .foregroundStyle(.white)
                                            }
                                            .offset(x: 20, y: 35)
                                    }
                                }
                                
                                Text(
                                    chick.locked ? "???" : chick.chicken.skin.rawValue
                                )
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary6)
                                .offset(y: -5)
                            }
                            .onTapGesture {
                                if !chick.locked {
                                    chicken = chick.chicken
                                }
                            }
                        }
                        .padding(.bottom, 2.5)
                    }
                    .padding()
                }
            }
            .frame(width: 355, height: 450)
            .background(.primary1)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.5), radius: 2, x: 3, y: 4)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .inset(by: -1.5)
                .stroke(.white, lineWidth: 3)
            )
        }
        .navigationTitle("Collected Skins")
    }
}

#Preview {
    CollectableItemsView()
}
