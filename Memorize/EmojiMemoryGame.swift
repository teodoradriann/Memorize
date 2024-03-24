//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Teodor Adrian on 2/29/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    //static = make the emojis global but put it in my class
    //private = access it only in here
    
    @Published private var model: MemoryGame<String>
    var theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(of: theme)
    }
    
    private static func createMemoryGame(of theme: Theme) -> MemoryGame<String> {
        guard !theme.emojis.isEmpty else {
            fatalError("Theme emojis array is empty")
        }
        
        return MemoryGame(theme: theme) { pairIndex in
            let index = pairIndex % theme.emojis.count // Asigură-te că indexul este în intervalul corect
            return theme.emojis[index]
        }
    }
    
    var numberOfPairs: Int {
        model.theme.numberOfCards
    }
    
    var score: Int {
        model.score
    }
    
    var themeName: String {
        model.theme.name
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var gameOver: Bool {
        model.gameOver
    }
    
    var color: Color {
        Color(rgba: model.theme.color)
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func startNewGame(){
        self.model = EmojiMemoryGame.createMemoryGame(of: self.theme)
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
