//
//  DraggableView.swift
//  Mini2
//
//  Created by Jovanna Melissa on 22/06/24.
//

import SwiftUI

struct DraggableView: View {
    @State private var isDragging:Bool = false
    @Binding var location: CGPoint
        
    private let imageName:String
        
    init(location: Binding<CGPoint>, imageName: String) {
            self._location = location
            self.imageName = imageName
    }
        
    var dragGesture: some Gesture{
        DragGesture()
            .onChanged { value in
                self.location.x = value.location.x
                self.isDragging = true
            }
            
            .onEnded { _ in
                self.isDragging = false
            }
    }
        
    var body: some View{
        Image(imageName)
            .position(location)
            .gesture(dragGesture)
    }
}
