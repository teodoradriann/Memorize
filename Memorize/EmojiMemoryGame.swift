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
    
    private static func createMemoryGame(of theme: Theme) -> MemoryGame<String> {
        MemoryGame(theme: theme) { pairIndex in
                return theme.emojis[pairIndex]
        }
    }
    
    private static let themes : [Theme] = [
        Theme(name: "Animals", emojis: animals, numberOfPairs: animals.count, color: "red"),
        Theme(name: "Foods", emojis: foods, numberOfPairs: foods.count, color: "indigo"),
        Theme(name: "Faces", emojis: faces, numberOfPairs: faces.count, color: "brown"),
        Theme(name: "Sports", emojis: sports, numberOfPairs: sports.count, color: "purple"),
        Theme(name: "Vehicles", emojis: vehicles, numberOfPairs: vehicles.count, color: "blue"),
        Theme(name: "Countires", emojis: flags, numberOfPairs: flags.count, color: "gray")
    ]
    
    @Published private var model = createMemoryGame(of: themes.randomElement()!)
    
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
        case "red":
                .red
        case "gray":
                .gray
        case "brown":
                .brown
        case "purple":
                .purple
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
        self.model = EmojiMemoryGame.createMemoryGame(of: randomTheme)
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
            self.model = EmojiMemoryGame.createMemoryGame(of: selectedTheme)
        }
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
