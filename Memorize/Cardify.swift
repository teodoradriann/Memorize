//
//  Cardify.swift
//  Memorize
//
//  Created by Teodor Adrian on 3/9/24.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFacedUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 20)
            base.strokeBorder(lineWidth: 3)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFacedUp ? 1 : 0)
            base.fill()
                .opacity(isFacedUp ? 0 : 1)
        }
    }
}

extension View {
    func cardify(isFacedUp: Bool) -> some View {
        self.modifier(Cardify(isFacedUp: isFacedUp))
    }
}
