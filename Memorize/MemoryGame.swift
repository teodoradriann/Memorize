//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Teodor Adrian on 2/29/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContent: (Int) -> CardContent) {
        cards = []
        for i in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContent(i)
            cards.append(Card(content: content, id: "\(i)a"))
            cards.append(Card(content: content, id: "\(i)b"))
        }
        shuffle()
    }
    
    var indexOfTheOneAndOnlyFacedUpCard: Int?
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: { cardIndex in
            cardIndex.id == card.id
        })
        {
            if !cards[chosenIndex].isFacedUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFacedUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
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
    }
    
    mutating func shuffle(){
        cards.shuffle()
        for i in cards.indices {
            cards[i].isFacedUp = false
            cards[i].isMatched = false
        }
    }
    
    mutating func changeTheme(numberOfPairsOfCards: Int, cardContent: (Int) -> CardContent){
        cards.removeAll()
        for i in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContent(i)
            cards.append(Card(content: content, id: "\(i + 1)a"))
            cards.append(Card(content: content, id: "\(i + 1)b"))
        }
        shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        var isFacedUp = false
        var isMatched = false
        let content: CardContent
        var id: String
    }
}
