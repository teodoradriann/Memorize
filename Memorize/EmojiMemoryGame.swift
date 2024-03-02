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
    private static var emojis = ["🦭", "🦋", "🐌", "🦖", "🦇", "🐕", "🦫", "🐝", "🦎", "🐀", "🐍", "🐊"]
    private let animals = ["🦭", "🦋", "🐌", "🦖", "🦇", "🐕", "🦫", "🐝", "🦎", "🦘", "🐀", "🐪"]
    private let foods = ["🌭", "🍔", "🍟", "🍕", "🌮", "🌯", "🥗", "🥘", "🍣", "🍯", "🍚", "🥮"]
    private let faces = ["😆", "🥹", "🤓", "😎", "🥰", "🤨", "🤯", "😤", "😭", "🫠", "🥱", "🤠"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: emojis.count) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            }
            else {
                return "❓"
            }
        }
    }
        
    @Published private var model = createMemoryGame()

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func changeTheme(theme: String){
        if theme == "dog.fill" {
            model.changeTheme(numberOfPairsOfCards: EmojiMemoryGame.emojis.count) { index in
                animals[index]
            }
        } else if theme == "carrot.fill" {
            model.changeTheme(numberOfPairsOfCards: EmojiMemoryGame.emojis.count) { index in
                foods[index]
            }
        } else if theme == "smiley.fill"{
            model.changeTheme(numberOfPairsOfCards: EmojiMemoryGame.emojis.count) { index in
                faces[index]
            }
        }
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
