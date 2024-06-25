//
//  BasketDragViewModel.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 26/06/24.
//

import Foundation

class BasketDragViewModel: ObservableObject {
    @Published var show = [false, false, false]
    var counter = 0
    
    private static var basketVM: BasketDragViewModel?
    
    static func getInstance() -> BasketDragViewModel {
        if self.basketVM == nil {
            self.basketVM = BasketDragViewModel()
        }
        
        return Self.basketVM!
    }
    
    func updateBasket() {
        show[counter] = true
        counter += 1
    }
    
    func resetBasket() {
        counter = 0
        show = [false, false, false]
    }
}
