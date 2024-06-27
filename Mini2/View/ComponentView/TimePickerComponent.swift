//
//  TimePickerComponent.swift
//  Mini2
//
//  Created by Putri Wulandari Oktaviani on 24/06/24.
//

import SwiftUI

struct TimePickerComponent: View {
    @State private var selectedHour = 1
    @State private var studySession = 2
    @State private var breakSession = 1
    
    private let hours = Array(1..<7)
    var timeAssignVM = TimeAssignmentViewModel.getInstance()
    
    var body: some View {
        ZStack {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 215, height: 47)
              .background(.white)
              .cornerRadius(12)
              .shadow(color: Color.black.opacity(0.3), radius: 2, x: 3, y: 4)
            
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 200, height: 32)
              .background(.white)
              .cornerRadius(5)
              .overlay(
                RoundedRectangle(cornerRadius: 5)
                  .inset(by: -1.25)
                  .stroke(.black, lineWidth: 2.5)
              )
            
            ZStack {
                Picker("Select Hour", selection: $selectedHour) {
                    ForEach(hours, id: \.self) { hour in
                        VStack {
                            Text("\(hour)")
                                .foregroundStyle(.primary6)
                                .offset(x: -40)
                        }
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 220, height: 150)
                .onChange(of: selectedHour) { oldValue, newValue in
                    timeAssignVM.timeAssignment(selectedHour)
                    studySession = timeAssignVM.studySessionTotal
                    breakSession = timeAssignVM.breakSessionTotal
                }
                
                Text("Hours")
                    .font(.system(size: 20))
                    .padding(.horizontal, 10)
                    .foregroundStyle(.primary6)
                    .offset(x: 25)
            }
            
        }
        .padding(.bottom, 20)

        
        ZStack {
            HStack {
                ZStack {
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 138, height: 130)
                      .background(.white)
                      .cornerRadius(12)
                      .shadow(color: Color.black.opacity(0.3), radius: 2, x: 3, y: 4)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(studySession)x")
                            .font(.system(size: 19))
                            .fontWeight(.bold)
                            .foregroundStyle(.primary5)
                        Text("25 m")
                            .font(.system(size: 33))
                            .fontWeight(.bold)
                            .foregroundStyle(.primary5)
                        Text("Learning")
                            .font(.system(size: 19))
                            .foregroundStyle(.primary5)
                    }
                    .padding(10)
                    .frame(width: 128, alignment: .leading)
                    .background(.primary1)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .inset(by: 1.25)
                            .stroke(.black, lineWidth: 2.5)
                    )
                }
                
                ZStack {
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 138, height: 130)
                      .background(.white)
                      .cornerRadius(12)
                      .shadow(color: Color.black.opacity(0.3), radius: 2, x: 3, y: 4)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(breakSession)x")
                            .font(.system(size: 19))
                            .fontWeight(.bold)
                            .foregroundStyle(.yellow5)
                        Text("5 m")
                            .font(.system(size: 33))
                            .fontWeight(.bold)
                            .foregroundStyle(.yellow5)
                        Text("Resting")
                            .font(.system(size: 19))
                            .foregroundStyle(.yellow5)
                    }
                    .padding(10)
                    .frame(width: 128, alignment: .leading)
                    .background(.yellow1)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .inset(by: 1.25)
                            .stroke(.black, lineWidth: 2.5)
                    )
                }
            }
            
        }

    }
}

#Preview {
    TimePickerComponent()
}
