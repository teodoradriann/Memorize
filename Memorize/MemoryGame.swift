//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Teodor Adrian on 2/29/24.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContent: (Int) -> CardContent) {
        cards = []
        for i in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContent(i)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        shuffle()
    }
    
    
    mutating func choose(_ card: Card){
        
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    mutating func changeTheme(numberOfPairsOfCards: Int, cardContent: (Int) -> CardContent){
        cards.removeAll()
        for i in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContent(i)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        shuffle()
    }
    
    struct Card {
        var isFacedUp = true
        var isMatched = false
        let content: CardContent
    }
}
