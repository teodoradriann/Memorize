//
//  Theme.swift
//  Memorize
//
//  Created by Teodor Adrian on 3/6/24.
//

import Foundation

struct Theme {
    private(set) var name: String
    private(set) var emojis: [String]
    private(set) var numberOfPairs: Int
    private(set) var color: String
    
    init(name: String, emojis: [String], numberOfPairs: Int, color: String) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairs = numberOfPairs > emojis.count ? emojis.count : numberOfPairs
        self.color = color
    }
}
