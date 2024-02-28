//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Teodor Adrian on 2/29/24.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card){
        
    }
    
    struct Card {
        var isFacedUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
