//
//  EggCatchingView.swift
//  Mini2
//
//  Created by Jovanna Melissa on 25/06/24.
//

import SwiftUI

struct EggCatchView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let eggTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var basketTapped = true
    @State private var leftArrowXAmount = 60.0
    @State private var rightArrowXAmount = 60.0
    @State private var basketPosition:CGPoint = CGPoint(x: 200.0, y: 670.0)
    @State private var eggFallCounter = 0
    @State var chick: Chicken = UserViewModel.readChick()
    @State var eggBroke = false
    @State var randomXPos = 200.0
    @State var eggYPos = 150.0
    @State var catchCounter = 0
    @State var fadeEgg = false
    @Binding var sessionState: SessionState
    
    var basketVM = BasketDragViewModel.getInstance()
    var gachaVM = EggGachaViewModel.getInstance()
    
    var body: some View {
        ZStack {
            if !basketTapped {
                Image(chick.getChickenName())
                    .EggCatchChickIMG
                    .padding(.top, 50)
                    .position(CGPoint(x: 200.0, y: 100.0))
                
                Text("Catch the egg!")
                    .font(.system(size: 27))
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary6)
                
                HStack{
                    Image("leftarrow")
                        .position(CGPoint(x: leftArrowXAmount, y: 650.0))
                        .animation(.easeInOut(duration: 1), value: leftArrowXAmount)
                    
                    
                    Image("Nest")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 185)
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
                    DraggableView(location: $basketPosition, imageName: "Nest")
//                        .onChange(of: basketPosition){ oldValue, newValue in
//                            self.basketPosition.x = newValue.x
////                            print("Basket position updated: \(newValue)")
//                        }
                    
                    VStack{
                        ZStack {
                            Image(eggBroke ? "TelorPecah" : "Egg")
                                .EggCatchEggIMG
                                .opacity(fadeEgg ? 0 : 1)
                                .position(x: randomXPos, y: eggYPos)
                                
                            Image(chick.getChickenName())
                                .EggCatchChickIMG
                                .position(x: randomXPos + 15, y: 130.0)
                        }
                        .onAppear {
                            randomXPos = .random(in: 85...285)
                        }
                        .onReceive(eggTimer) { _ in
                            if eggFallCounter == 3 {
                                if catchCounter == 0 {
                                    sessionState = .FailedToCatch
                                } else {
                                    basketVM.resetBasket()
                                    gachaVM.setEggAmount(catchCounter)
                                    sessionState = .ChooseEggs
                                }
                            } else {
                                eggFallCounter += 1
                                print("Egg fall: \(eggFallCounter) || Catched Egg: \(catchCounter)")
                            }
                            
                            withAnimation(.easeInOut(duration: 1.5)) {
                                eggYPos = 650
                            } completion: {
                                if randomXPos <= (basketPosition.x + 40) && randomXPos >= (basketPosition.x - 40) {
                                    catchCounter += 1
                                    
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        fadeEgg = true
                                    } completion: {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            basketVM.updateBasket()
                                        } completion: {
                                            resetValue()
                                        }
                                    }
                                } else {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        eggBroke = true
                                    } completion: {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            fadeEgg = true
                                        } completion: {
                                            eggBroke = false
                                            resetValue()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    private func resetValue() {
        eggYPos = 150
        randomXPos = .random(in: 85...285)
        fadeEgg = false
    }
}

//#Preview {
//    EggCatchView()
//}
