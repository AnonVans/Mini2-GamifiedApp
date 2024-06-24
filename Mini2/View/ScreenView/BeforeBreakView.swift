//
//  BeforeBreakView.swift
//  Mini2
//
//  Created by Jovanna Melissa on 22/06/24.
//

import SwiftUI

struct BeforeBreakView: View {
    var currentSession:Int
    var totalSession:Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let eggTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var timeRemaining = 0.0
    @State private var format = "0:0"
    @State private var yAmount = 100.0
    @State private var swipedUp = false
    @State private var leftArrowXAmount = 60.0
    @State private var rightArrowXAmount = 60.0
    @State private var basketTapped = false
    @State private var eggXAmount = CGFloat.random(in: 50..<351)
    @State private var eggYAmount = 0.0
    @State private var isAnimating = false
//    let targetPosition:CGFloat = 300
//    let eggSize: CGSize = CGSize(width: 50, height: 70)
//    let basketSize: CGSize = CGSize(width: 150, height: 150)
    @State private var eggCounter = 0
    @State private var basketPosition:CGPoint = CGPoint(x: 200.0, y: 670.0)
    @State private var eggPositions: [CGPoint] = Array(repeating: CGPoint(x: 0, y: 0), count: 3)
    @State private var currentEggIndex: Int = 0
    @State private var chickenPosition = CGPoint(x: 100, y: 100.0)
    
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .foregroundStyle(Color.primary1)
                    .ignoresSafeArea()
                
                VStack{
                    Text("Study Session \(currentSession) of \(totalSession)")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                    
                    if(timeRemaining > 0 && swipedUp == false){
                        Image("Ayam")
                            .padding(.top, 50)
                        
                        Text("\(format)")
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
                            .onAppear(perform: {
                                timeFormat(remainingTime: timeRemaining)
                            })
                            .onChange(of: timeRemaining){
                                timeFormat(remainingTime:timeRemaining)
                            }
                            .fontWeight(.regular)
                            .font(.system(size: 56))
                            
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
                                    .onChange(of: basketPosition){newValue in
                                        self.basketPosition.x = newValue.x
                                        print("Basket position updated: \(newValue)")
                                    }
                                
                                VStack{
                                    Image("Ayam")
//                                        .position(chickenPosition)
                                        .frame(width: 160)
                                    ZStack {
                                        ForEach(0..<eggPositions.count, id: \.self) { index in
                                            Image("telor")
                                                .resizable()
                                                .frame(width: 60, height: 100)
                                                .position(eggPositions[index])
                                                .opacity(index <= currentEggIndex ? 1 : 0)
                                                .animation(.default, value: currentEggIndex)
                                        }
                                    }
                                    .onAppear {
                                        for i in 0..<eggPositions.count {
                                            eggPositions[i].x = CGFloat.random(in: 50..<351)
                                            chickenPosition.x = eggPositions[i].x
                                        }
                                    }
                                    .onReceive(eggTimer) { _ in
                                        if currentEggIndex < eggPositions.count {
                                            withAnimation(Animation.easeInOut(duration: 1)) {
                                                eggPositions[currentEggIndex].y = 400
                                            }
                                            currentEggIndex += 1
                                        }
                                    }
                                }
                                    
                                                                
                                
                                //                                    Image("telor")
                                //                                        .resizable()
                                //                                        .frame(width: 60, height: 100)
                                //                                        .position(CGPoint(x: eggXAmount, y: eggYAmount))
                                //                                        .onReceive(timer){input in
                                //                                            if(eggYAmount <= 250 && eggYAmount < basketPosition.y){
                                //                                                eggYAmount += 200
                                //                                            }
                                //                                        }
                                //                                        .animation(.easeInOut(duration: 1), value: eggYAmount)
                                //                                        .onChange(of: eggYAmount){
                                //                                            if(eggYAmount == 400){
                                //                                                checkEggCaught()
                                //                                            }
                                //                                        }
                                Spacer()
                            }
                        }
                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden()
    }
    
    private func checkEggCaught() {
            // Calculate the position of the egg and the basket in the coordinate system
//        let eggFrame = CGRect(x: eggPosition.x, y: eggPosition.y, width: eggSize.width, height: eggSize.height)
//        let basketFrame = CGRect(x: basketPosition.x, y: basketPosition.y, width: basketSize.width, height: basketSize.height)
//            // Check if the egg frame intersects with the basket frame
//        if eggFrame.intersects(basketFrame) {
//            eggCounter += 1 // Increment the egg counter
//            resetEgg() // Reset the egg to the initial position
//            print("hello")
//        } else {
//            print("nooo")
//        }
//        if(basketPosition.x == eggPosition.x){
//            print("yayy")
//        } else {
//            print("noo")
//        }
        
        if(eggXAmount <= basketPosition.x + 50 && eggXAmount >= basketPosition.x - 50){
            eggCounter += 1
            print("yesss")
            print("\(basketPosition.x) and \(eggXAmount)")
//            resetEgg()
        } else {
            print("no")
            print("\(basketPosition.x) and \(eggXAmount)")
        }
        
        print("eggcounter: \(eggCounter)")
    }

        private func resetEgg() {
            eggXAmount = CGFloat.random(in: 50..<351)
            eggYAmount = 0.0
        }
}

#Preview {
    BeforeBreakView(currentSession: 0, totalSession: 0)
}

extension BeforeBreakView{
    func timeFormat(remainingTime: TimeInterval){
        let duration = Duration.seconds(timeRemaining)
        format = duration.formatted(
            .time(pattern: .minuteSecond))
    }
}
