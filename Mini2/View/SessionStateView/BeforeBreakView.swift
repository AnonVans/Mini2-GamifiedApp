//
//  BeforeBreakView.swift
//  Mini2
//
//  Created by Jovanna Melissa on 22/06/24.
//

import SwiftUI

struct BeforeBreakView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let eggTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    @State private var timeRemaining = 30.0
    @State private var format = "0:0"
    @State private var yAmount = 100.0
    @State private var swipedUp = false
    @State private var leftArrowXAmount = 60.0
    @State private var rightArrowXAmount = 60.0
    @State private var basketTapped = false
    @State private var eggCounter = 0
    @State private var basketPosition:CGPoint = CGPoint(x: 200.0, y: 670.0)
    @State private var eggPositions: [CGPoint] = Array(repeating: CGPoint(x: 0, y: 200), count: 3)
    @State private var eggDisappear: [Bool] = Array(repeating: false, count: 3)
    @State private var currentEggIndex: Int = 0
    @State private var chickenPositions: [CGPoint] = Array(repeating: CGPoint(x: 100, y: 100), count: 3)
    
    @State var callSignal = false
    @Binding var sessionState: SessionState
    
    var body: some View {
        ZStack{
            VStack {
                //Update
                Text("Study Session 0 of 1")
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
            }
            VStack{
                
                if(!callSignal && !swipedUp){
                    Image("Ayam")
                        .padding(.top, 100)
                    
                    TimerComponent(currDuration: 30, signal: $callSignal)
                        
                    Image("arrowupnew")
                        .position(CGPoint(x: 200.0, y: yAmount))
                        .animation(.easeInOut(duration: 1), value: yAmount)
                        .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                            .onEnded { value in
                                let horizontalAmount = value.translation.width
                                let verticalAmount = value.translation.height
                                if abs(horizontalAmount) > abs(verticalAmount) {
                                    print(horizontalAmount < 0 ? "left swipe" : "right swipe")
                                } else {
                                    print(verticalAmount < 0 ? "up swipe" : "down swipe")
                                    swipedUp = true
                                }
                            })
                        .onReceive(timer) { input in
                            if timeRemaining > 0{
                                timeRemaining -= 1
                                if(yAmount >= 100.0){
                                    yAmount -= 50
                                } else {
                                    yAmount = 120.0
                                }
                            }
                        }
                    
                    Text("Swipe up to rest")
                        .fontWeight(.regular)
                        .font(.system(size: 27))
                        .padding(.bottom, 80)
                    
                } else {
                    
                    if(basketTapped == false){
                        Image("Ayam")
                            .padding(.top, 50)
                        
                        HStack{
                            Image("leftarrow")
                                .position(CGPoint(x: leftArrowXAmount, y: 400.0))
                                .animation(.easeInOut(duration: 1), value: leftArrowXAmount)
                            
                            
                            Image("basket")
                                .position(CGPoint(x: 65.0, y: 400.0))
                                .onTapGesture {
                                    basketTapped = true
                                }
                            
                            Image("rightarrow")
                                .position(CGPoint(x: rightArrowXAmount, y: 400.0))
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
                                .onChange(of: basketPosition){ oldValue, newValue in
                                    self.basketPosition.x = newValue.x
                                    print("Basket position updated: \(newValue)")
                                }
                            
                            VStack{
                                ZStack {
                                    ForEach(0..<eggPositions.count, id: \.self) { index in
                                        Image("Ayam")
                                            .padding(.top, 50)
                                            .position(chickenPositions[index])
                                            .opacity(index <= currentEggIndex && !eggDisappear[index] ? 1 : 0)
                                        
                                        Image("telor")
                                            .resizable()
                                            .frame(width: 60, height: 100)
                                            .position(eggPositions[index])
                                            .opacity(index <= currentEggIndex && !eggDisappear[index] ? 1 : 0)
                                            .animation(.default, value: currentEggIndex)
                                    }
                                }
                                .onAppear {
                                    for i in 0..<eggPositions.count {
                                        eggPositions[i].x = CGFloat.random(in: 50..<351)
                                        chickenPositions[i].x = eggPositions[i].x
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
        }
            
        }
    
    private func checkEggCaught(currentEggIndex: Int) {
        if(eggPositions[currentEggIndex].x <= basketPosition.x + 50 && eggPositions[currentEggIndex].x >= basketPosition.x - 50){
            eggCounter += 1
            print("yesss")
            print("\(basketPosition.x) and \(eggPositions[currentEggIndex].x)")
        } else {
            print("no")
            print("\(basketPosition.x) and \(eggPositions[currentEggIndex].x)")
        }
        
        print("eggcounter: \(eggCounter)")
    }
}

//#Preview {
//    BeforeBreakView()
//}

extension BeforeBreakView{
    func timeFormat(remainingTime: TimeInterval){
        let duration = Duration.seconds(timeRemaining)
        format = duration.formatted(
            .time(pattern: .minuteSecond))
    }
}
