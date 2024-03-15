//
//  Cardify.swift
//  Memorize
//
//  Created by Teodor Adrian on 3/9/24.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    init(isFacedUp: Bool) {
        rotation = isFacedUp ? 0 : 180
    }
    var isFacedUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get {return rotation}
        set {rotation = newValue}
    }
    var rotation: Double
    
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
        .rotation3DEffect(
            .degrees(rotation), axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
}

extension View {
    func cardify(isFacedUp: Bool) -> some View {
        self.modifier(Cardify(isFacedUp: isFacedUp))
    }
}
