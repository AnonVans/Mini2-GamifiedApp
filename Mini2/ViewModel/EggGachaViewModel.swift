//
//  EggGachaViewModel.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 25/06/24.
//

import Foundation

class EggGachaViewModel {
    private var eggAmount = 3
    private var chickenSkins = [CollectionItem]()
    
    private static var gachaVM: EggGachaViewModel?
    
    init() {
        fetchData()
    }
    
    static func getInstance() -> EggGachaViewModel {
        if self.gachaVM == nil {
            self.gachaVM = EggGachaViewModel()
        }
        return self.gachaVM!
    }
    
    func fetchData() {
        do {
            let url = Bundle.main.url(forResource: "ChickenSkins", withExtension: "json")
            let data = try Data(contentsOf: url!)
            let decoder = JSONDecoder()
            self.chickenSkins = try decoder.decode([CollectionItem].self, from: data)
        } catch {
            print("Failed to fetch data: \(error.localizedDescription)")
        }
    }
    
    func getChickens() -> [CollectionItem] {
        return self.chickenSkins
    }
    
    func setEggAmount(_ amount: Int) {
        self.eggAmount = amount
    }
    
    func getEggAmount() -> Int {
        return self.eggAmount
    }
    
    func checkChickenLock(_ chicken: Chicken) -> Bool {
        var isLocked: Bool = true
        
        for newChick in chickenSkins {
            if newChick.chicken.isSame(chicken) {
                isLocked = newChick.locked
            }
        }
        
        return isLocked
    }
    
    func unlockChicken() {
        
    }
    
    func gachaChicken() -> Chicken {
        let maxIndex = CGFloat(chickenSkins.count - 2)
        let chickenItem = chickenSkins[Int(CGFloat.random(in: 1...maxIndex))]
        let prizeChick = chickenItem.chicken
        
        if checkChickenLock(prizeChick) {
            unlockChicken()
        } else {
            //Tambah poin user
        }
        
        return prizeChick
    }
    
    func updateChicken(_ chick: Chicken) {
        
    }
}
