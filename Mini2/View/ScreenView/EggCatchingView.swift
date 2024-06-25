//
//  EggCatchingView.swift
//  Mini2
//
//  Created by Jovanna Melissa on 25/06/24.
//

import SwiftUI

struct EggCatchingView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let eggTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var basketTapped = false
    @State private var leftArrowXAmount = 60.0
    @State private var rightArrowXAmount = 60.0
    @State private var basketPosition:CGPoint = CGPoint(x: 200.0, y: 670.0)
    @State private var eggPositions: [CGPoint] = Array(repeating: CGPoint(x: 0, y: 150), count: 3)
    @State private var eggDisappear: [Bool] = Array(repeating: false, count: 3)
    @State private var currentEggIndex: Int = 0
    @State private var chickenPositions: [CGPoint] = Array(repeating: CGPoint(x: 100, y: 100), count: 3)
    @State private var eggCounter = 0
    @State private var eggBroken: [Bool] = Array(repeating: false, count: 3)
    @State private var brokenEggPositions: [CGPoint] = Array(repeating: CGPoint(x: 0, y: 650), count: 3)
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(Color.primary1)
                .ignoresSafeArea()
            
            if(basketTapped == false){
                Image("Ayam")
                    .padding(.top, 50)
                    .position(CGPoint(x: 200.0, y: 100.0))
//                Image("telorpecah")
//                    .resizable()
//                    .frame(width: 190, height: 90)
                
                HStack{
                    Image("leftarrow")
                        .position(CGPoint(x: leftArrowXAmount, y: 650.0))
                        .animation(.easeInOut(duration: 1), value: leftArrowXAmount)
                    
                    
                    Image("basket")
                        .position(CGPoint(x: 65.0, y: 650.0))
                        .onTapGesture {
                            basketTapped = true
                        }
                    
                    Image("rightarrow")
                        .position(CGPoint(x: rightArrowXAmount, y: 650.0))
                        .animation(.easeInOut(duration: 1), value: rightArrowXAmount)
                }
                .onReceive(timer) { input in
                    if(basketTapped == false){
                        if(leftArrowXAmount >= 50 && rightArrowXAmount <= 80){
                            leftArrowXAmount -= 20
                            rightArrowXAmount += 20
                        } else {
                            leftArrowXAmount = 60
                            rightArrowXAmount = 60
                        }

                    }
                }
            } else {
                ZStack{
                    DraggableView(location: $basketPosition, imageName: "basket")
                        .onChange(of: basketPosition){newValue in
                            self.basketPosition.x = newValue.x
                            print("Basket position updated: \(newValue)")
                        }
                    
                    VStack{
                        ZStack {
                            ForEach(0..<eggPositions.count, id: \.self) { index in
                                
                                Image("telor")
                                    .resizable()
                                    .frame(width: 60, height: 100)
                                    .position(eggPositions[index])
                                    .opacity(index <= currentEggIndex && !eggDisappear[index] ? 1 : 0)
                                    .animation(.default, value: currentEggIndex)
                                
                                Image("Ayam")
                                    .padding(.top, 50)
                                    .position(chickenPositions[index])
                                    .opacity(index <= currentEggIndex && !eggDisappear[index] ? 1 : 0)
                                
                                Image("telorpecah")
                                    .resizable()
                                    .frame(width: 190, height: 90)
                                    .position(brokenEggPositions[index])
                                    .opacity(eggBroken[index] ? 1 : 0)
                                    .animation(.easeInOut, value: eggBroken)
                            }
                        }
                        .onAppear {
                            for i in 0..<eggPositions.count {
                                eggPositions[i].x = CGFloat.random(in: 50..<351)
                                chickenPositions[i].x = eggPositions[i].x
                                brokenEggPositions[i].x = eggPositions[i].x
                            }
                        }
                        .onReceive(eggTimer) { _ in
                            if currentEggIndex < eggPositions.count {
                                withAnimation(Animation.easeInOut(duration: 1)) {
                                    eggPositions[currentEggIndex].y = 650
                                } completion: {
                                    checkEggCaught(currentEggIndex: currentEggIndex)
                                    
                                    currentEggIndex += 1
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    eggDisappear[currentEggIndex - 1] = true
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    private func checkEggCaught(currentEggIndex: Int) {
        if(eggPositions[currentEggIndex].x <= basketPosition.x + 50 && eggPositions[currentEggIndex].x >= basketPosition.x - 50){
            eggCounter += 1
            print("yesss")
            print("\(basketPosition.x) and \(eggPositions[currentEggIndex].x)")
        } else {
            eggBroken[currentEggIndex] = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                eggBroken[currentEggIndex] = false
            }
        }
        
        print("eggcounter: \(eggCounter)")
    }
}

#Preview {
    EggCatchingView()
}
