//
//  EggGachaViewModel.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 25/06/24.
//

import Foundation
import SwiftData

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
    
    func checkChickenLock(_ chicken: Chicken, _ datas: [SkinsDataModel], _ dataModel: ModelContext) -> Bool {
        var isLocked: Bool = true
        
        for newChick in datas {
            if ((newChick.items?.chicken.isSame(chicken)) != nil) {
                isLocked = ((newChick.items?.locked) != nil)
            }
        }
        
        return isLocked
    }
    
    func gachaChicken(_ skinData: [SkinsDataModel], _ dataModel: ModelContext) -> Chicken {
        let maxIndex = CGFloat(chickenSkins.count - 2)
        let rng = Int(CGFloat.random(in: 2...maxIndex))
        let chickenItem = chickenSkins[rng]
        let prizeChick = chickenItem.chicken
        
        if checkChickenLock(prizeChick, skinData, dataModel) {
            SkinsDataViewModel.unlockChicken(rng, skinData, dataModel)
        } else {
            //Tambah poin user
        }
        
        return prizeChick
    }
    
    func updateChicken(_ chick: Chicken) {
        UserViewModel.saveChick(chick)
    }
}
