//
//  CardView.swift
//  Memorize
//
//  Created by Teodor Adrian on 3/9/24.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack{
            Pie(endAngle: .degrees(240))
                .opacity(0.8)
                .padding(3)
                .foregroundStyle(.red)
            Text(card.content)
                .font(.system(size: 100))
                .minimumScaleFactor(0.01)
                .aspectRatio(1, contentMode: .fit)
        }
        .cardify(isFacedUp: card.isFacedUp)
        .opacity(card.isFacedUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    CardView(MemoryGame<String>.Card(content: "X", id: "test1"))
        .padding()
        .foregroundStyle(.blue)
}
