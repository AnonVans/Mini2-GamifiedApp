//
//  Extensions.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 22/06/24.
//

import Foundation
import SwiftUI

extension Text {
    
}

extension ButtonType {
    var fill : Color {
        return (self == .Solid) ? .primary5 : .white
    }
    
    var foreground : Color {
        return (self == .Solid) ? .white : .primary5
    }
}

extension ButtonSize {
    var height : Double {
        return (self == .Large) ? 52 : 34
    }
    
    var fontSize : Double {
        return (self == .Large) ? 19 : 16
    }
    
    var cornerRadius : Double {
        return (self == .Large) ? 20 : 12
    }
}

