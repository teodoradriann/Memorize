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
    
    private static let animals = ["🦭", "🦋", "🐌", "🦖", "🦇", "🐕", "🦫", "🐝", "🦎", "🦘", "🐀", "🐪"]
    private static let foods = ["🌭", "🍔", "🍟", "🍕", "🌮", "🌯", "🥗", "🥘", "🍣", "🍯", "🍚", "🥮"]
    private static let faces = ["😆", "🥹", "🤓", "😎", "🥰", "🤨", "🤯", "😤", "😭", "🫠", "🥱", "🤠"]
    private static let sports = ["⚽️", "🏀", "🏈", "⚾️", "🏓", "🏐", "🏉", "🎣"]
    private static let vehicles = ["🚗", "🚕", "🚙", "🚔", "🏍️", "🚜"]
    private static let flags = ["🇷🇴", "🇺🇸", "🇬🇧", "🇩🇪", "🇫🇷", "🇯🇵", "🇨🇳", "🇰🇷", "🇪🇸", "🇱🇺", "🇬🇪", "🏴󠁧󠁢󠁷󠁬󠁳󠁿"]
    
    private static func createMemoryGame(of theme: Theme, score: Int) -> MemoryGame<String> {
        MemoryGame(theme: theme, score: 0) { pairIndex in
                return theme.emojis[pairIndex]
        }
    }
    
    private static let themes : [Theme] = [
        Theme(name: "Animals", emojis: animals, numberOfPairs: animals.count, color: "white"),
        Theme(name: "Foods", emojis: foods, numberOfPairs: foods.count, color: "indigo"),
        Theme(name: "Faces", emojis: faces, numberOfPairs: faces.count, color: "brown"),
        Theme(name: "Sports", emojis: sports, numberOfPairs: sports.count, color: "mint"),
        Theme(name: "Vehicles", emojis: vehicles, numberOfPairs: vehicles.count, color: "blue"),
        Theme(name: "Countires", emojis: flags, numberOfPairs: flags.count, color: "gray")
    ]
    
    @Published private var model = createMemoryGame(of: themes.randomElement()!, score: 0)
    
    var numberOfPairs: Int {
        model.theme.numberOfPairs
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
        switch model.theme.color {
        case "white":
                .white
        case "gray":
                .gray
        case "brown":
                .brown
        case "mint":
                .mint
        case "blue":
                .blue
        case "indigo":
                .indigo
        default:
                .gray
        }
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func startNewGame(){
        let randomTheme = EmojiMemoryGame.themes.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame(of: randomTheme, score: 0)
    }
    
    func changeTheme(theme: String) {
        let themeMappings: [String: Theme] = [
            "dog.fill": EmojiMemoryGame.themes[0],
            "carrot.fill": EmojiMemoryGame.themes[1],
            "smiley.fill": EmojiMemoryGame.themes[2],
            "soccerball": EmojiMemoryGame.themes[3],
            "car.fill": EmojiMemoryGame.themes[4],
            "flag.fill": EmojiMemoryGame.themes[5]
        ]
        
        if let selectedTheme = themeMappings[theme] {
            self.model = EmojiMemoryGame.createMemoryGame(of: selectedTheme, score: 0)
        }
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
