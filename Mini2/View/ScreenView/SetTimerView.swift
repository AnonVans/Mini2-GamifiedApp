//
//  SetTimerView.swift
//  Mini2
//
//  Created by Jovanna Melissa on 22/06/24.
//

import SwiftUI

struct SetTimerView: View {
    @State var studyTime = 0
    
    var body: some View {
        NavigationStack{
            HStack{
                Spacer()
                Picker("Study Time", selection: $studyTime){
                    Text("1").tag(0)
                    Text("2").tag(1)
                    Text("3").tag(2)
                    Text("4").tag(3)
                    Text("5").tag(4)
                    Text("6").tag(5)
                }
                .pickerStyle(.wheel)
                
                Text("Hour")
                Spacer()
            }
        }
    }
}

#Preview {
    SetTimerView()
}
