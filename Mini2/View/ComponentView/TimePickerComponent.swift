//
//  TimePickerComponent.swift
//  Mini2
//
//  Created by Putri Wulandari Oktaviani on 24/06/24.
//

import SwiftUI

struct TimePickerComponent: View {
    private let hours = Array(1..<7)
    var timeAssignVM = TimeAssignmentViewModel.getInstance()

    @State private var selectedHour = 1
    @State private var totalSession = 3
    
    // Function to calculate learning and break cycles
    func calculateCycles(for hours: Int) -> Int  {
        
        let totalMinutes = hours * 60
        let cycleMinutes = 25 + 5
        let numberOfCycles = totalMinutes / cycleMinutes
        return numberOfCycles
    }
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 4)
                .background(RoundedRectangle(cornerRadius: 12)
                .fill(Color.primary1))
                .frame(width: 200, height: 120)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 3, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: -0.5)
                        .stroke(.white, lineWidth: 4)
                )
               
            
            
            Picker("Select Hour", selection: $selectedHour) {
                ForEach(hours, id: \.self) { hour in
                    Text("\(hour)     Hours")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 200, height: 120)
            .onChange(of: selectedHour) { oldValue, newValue in
                timeAssignVM.timeAssignment(selectedHour)
                totalSession = timeAssignVM.totalSession
            }
            
        }
        .padding(.bottom, 20)

        
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 3)
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white))
                .frame(width: 319, height: 112)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 3, y: 4)
                .overlay(
                RoundedRectangle(cornerRadius: 12)
                .inset(by: -0.5)
                .stroke(.white, lineWidth: 3)

                )

            
            HStack {
                VStack (alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "text.book.closed.fill")
                            .resizable()
                            .foregroundColor(.blue)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                        
                        Text("Learning")
                    }
                    
                    HStack {
                        Image(systemName: "figure")
                            .resizable()
                            .foregroundColor(.blue)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                        
                        Text("Break")
                    }
                    
                    HStack {
                        Image(systemName: "repeat")
                            .resizable()
                            .foregroundColor(.blue)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                        
                        Text("Cycle")
                    }
                }
                
                Spacer()
                VStack (alignment: .trailing, spacing: 10) {
                    Text("25 min")
                    Text("5 min")
                    Text(String(totalSession))
                }

            }
            .padding(.horizontal, 70)
        }//Zstackbreakdown

    }
}

#Preview {
    TimePickerComponent()
}
