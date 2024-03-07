//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Teodor Adrian on 2/29/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var theme: Theme
    private(set) var score: Int
    private(set) var gameOver: Bool = false
    var indexOfTheOneAndOnlyFacedUpCard: Int?
    
    init(theme: Theme, score: Int, cardContent: (Int) -> CardContent) {
        self.theme = theme
        self.score = 0
        cards = []
        for i in 0..<max(2, theme.numberOfPairs) {
            let content = cardContent(i)
            cards.append(Card(content: content, id: "\(i)a"))
            cards.append(Card(content: content, id: "\(i)b"))
        }
        shuffle()
    }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id })
        {
            if !cards[chosenIndex].isFacedUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFacedUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if (cards[chosenIndex].previouslySeen || cards[potentialMatchIndex].previouslySeen){
                            score -= 1
                        }
                        cards[potentialMatchIndex].previouslySeen = true
                        cards[chosenIndex].previouslySeen = true
                    }
                    indexOfTheOneAndOnlyFacedUpCard = nil
                }
                else {
                    for i in cards.indices {
                        cards[i].isFacedUp = false
                    }
                    indexOfTheOneAndOnlyFacedUpCard = chosenIndex
                }
                cards[chosenIndex].isFacedUp = true
            }
        }
        let allMatched = cards.allSatisfy {$0.isMatched}
        if allMatched {
            gameOver = true
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
        for i in cards.indices {
            cards[i].isFacedUp = false
            cards[i].isMatched = false
        }
    }
    
    
    struct Card: Equatable, Identifiable {
        var isFacedUp = false
        var isMatched = false
        let content: CardContent
        var id: String
        var previouslySeen: Bool = false
    }
}
