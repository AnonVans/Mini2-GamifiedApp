//
//  DraggableView.swift
//  Mini2
//
//  Created by Jovanna Melissa on 22/06/24.
//

import SwiftUI

struct DraggableView: View {
    @ObservedObject var basketVM = BasketDragViewModel.getInstance()
    @State private var isDragging:Bool = false
    @Binding var location: CGPoint

    private let imageName:String
        
//    var basketVM = BasketDragViewModel.getInstance()
    
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
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 185)
            
            if basketVM.show[0] {
                Image("Egg")
                    .EggCatchEggIMG
                    .offset(x: -30, y: -50)
                    .rotationEffect(.degrees(-10))
            }
            if basketVM.show[1] {
                Image("Egg")
                    .EggCatchEggIMG
                    .offset(x: 35, y: -50)
                    .rotationEffect(.degrees(10))
            }
            if basketVM.show[2] {
                Image("Egg")
                    .EggCatchEggIMG
                    .offset(x: 00, y: -35)
            }
        }
        .position(location)
        .gesture(dragGesture)
//        .onAppear {
//            showing = basketVM.show
//        }
//        .onChange(of: basketVM.show) { _, _ in
//            showing = basketVM.show
//        }
    }
}

//#Preview {
//    testBasket()
//}
