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
        TimelineView(.animation){ timeline in
            if card.isFacedUp || !card.isMatched{
                ZStack{
                    Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                        .opacity(0.8)
                        .padding(3)
                        .foregroundStyle(.red)
                        .transition(.scale)
                    cardContents
                }.padding()
            } else {
                Color.clear
            }
        }
        .cardify(isFacedUp: card.isFacedUp)
        .opacity(card.isFacedUp || !card.isMatched ? 1 : 0)
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: 100))
            .minimumScaleFactor(0.01)
            .aspectRatio(1, contentMode: .fill)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.easeInOut(duration: 1), value: card.isMatched)
    }
}

#Preview {
    CardView(MemoryGame<String>.Card(content: "X", id: "test1"))
        .padding()
        .foregroundStyle(.blue)
}
