//
//  CongratulationsView.swift
//  Mini2
//
//  Created by Venussha Loveita Joyce Chandra on 24/06/24.
//

import SwiftUI

struct CongratulationsView: View {
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    
                }
                Image("congratsChicki")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0), Color.white.opacity(10)]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 500)
                            .padding(.top, 100)
                    )
                    .offset(y: 50)
                
                Text("Congratulations!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .offset(y: -100)
                    .foregroundColor(.blue)
                
                Text("You have made it to the end")
                    .font(.body)
                    .fontWeight(.bold)
                    .offset(y: -120)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("Back to Timer")
                        .fontWeight(.semibold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 3, x: 3, y: 3)
                }
            }
            
            
            
            
        }
        
    }
}

#Preview {
    CongratulationsView()
}
