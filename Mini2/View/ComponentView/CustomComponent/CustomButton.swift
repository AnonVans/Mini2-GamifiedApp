//
//  CustomButton.swift
//  Mini2
//
//  Created by Stevans Calvin Candra on 20/06/24.
//

import SwiftUI

enum ButtonType {
    case Solid
    case Outline
}

enum ButtonSize {
    case Large
    case Medium
}

extension ButtonType {
    func fill() -> Color {
        return (self == .Solid) ? .primary5 : .white
    }
    
    func foreground() -> Color {
        return (self == .Solid) ? .white : .primary5
    }
}

extension ButtonSize {
    func height() -> Double {
        return (self == .Large) ? 52 : 34
    }
    
    func size() -> Double {
        return (self == .Large) ? 19 : 16
    }
    
    func cornerRadius() -> Double {
        return (self == .Large) ? 20 : 12
    }
}

struct CustomButton: View {
    var type: ButtonType = .Outline
    var size: ButtonSize = .Large
    var width = 160.0
    var text = "Button"
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text(text)
                .font(Font.custom("SF Pro", size: size.size()))
              .multilineTextAlignment(.center)
              .foregroundColor(type.foreground())
        }
        .padding(.horizontal, 26)
        .padding(.vertical, 5)
        .frame(width: width, height: size.height(), alignment: .center)
        .background(type.fill())
        .cornerRadius(size.cornerRadius())
        .shadow(color: .black.opacity(0.3), radius: 2, x: 3, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: size.cornerRadius())
            .inset(by: 1.5)
            .stroke(type.foreground(), lineWidth: 3)
        )
    }
}

#Preview {
    CustomButton(type: .Solid, size: .Large, text: "Hello")
}
