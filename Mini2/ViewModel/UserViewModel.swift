//
//  UserViewModel.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 27/06/24.
//

import Foundation

class UserViewModel {
    
    static func saveChick(_ chicken: Chicken) {
        do {
            let chick = try JSONEncoder().encode(chicken)
            UserDefaults.standard.set(chick, forKey: UserDataEnum.Chicken.rawValue)
        } catch {
            print("Failed Saving Data: \(error.localizedDescription)")
        }
    }
    
    static func readChick() -> Chicken {
        if let chickData = UserDefaults.standard.data(forKey: UserDataEnum.Chicken.rawValue) {
            let chick = (try? JSONDecoder().decode(Chicken.self, from: chickData)) ?? Chicken()
            return chick
        } else {
            print("Failed Reading Data")
        }
        
        return Chicken()
    }
    
}
