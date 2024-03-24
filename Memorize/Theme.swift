//
//  Theme.swift
//  Memorize
//
//  Created by Teodor Adrian on 3/6/24.
//

import Foundation

struct Theme: Identifiable, Codable, Hashable {
    
    var name: String
    var emojis: [String]
    var numberOfCards: Int
    var color: RGBA
    var id = UUID()
    
    func json() throws -> Data {
        let encoded = try JSONEncoder().encode(self)
        return encoded
    }
    
    init(json: Data) throws {
        self = try JSONDecoder().decode(Theme.self, from: json)
    }
    
    init(name: String, emojis: [String], color: RGBA) {
        self.name = name
        self.emojis = emojis
        self.numberOfCards = emojis.count
        self.color = color
    }
    
    static var builtins: [Theme] {
        [
            Theme(name: "Animals", emojis: ["🦭", "🦋", "🐌", "🦖", "🦇", "🐕", "🦫", "🐝", "🦎", "🦘", "🐀", "🐪"], color: RGBA(color: .red)),
            Theme(name: "Food", emojis: ["🌭", "🍔", "🍟", "🍕", "🌮", "🌯", "🥗", "🥘", "🍣", "🍯", "🍚", "🥮"], color: RGBA(color: .indigo)),
            Theme(name: "Faces", emojis: ["😆", "🥹", "🤓", "😎", "🥰", "🤨", "🤯", "😤", "😭", "🫠", "🥱", "🤠"], color: RGBA(color: .brown)),
            Theme(name: "Sports", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🏓", "🏐", "🏉", "🎣"], color: RGBA(color: .purple)),
            Theme(name: "Vehicles", emojis: ["🚗", "🚕", "🚙", "🚔", "🏍️", "🚜"], color: RGBA(color: .blue)),
            Theme(name: "Countires", emojis: ["🇷🇴", "🇺🇸", "🇬🇧", "🇩🇪", "🇫🇷", "🇯🇵", "🇨🇳", "🇰🇷", "🇪🇸", "🇱🇺", "🇬🇪", "🏴󠁧󠁢󠁷󠁬󠁳󠁿"], color: RGBA(color: .gray))
        ]
    }
}

extension Theme {
    func arrayToString(_ array: [String]) -> String {
        var str = ""
        for i in array {
            str += i
            str += " "
        }
        return str
    }
}
