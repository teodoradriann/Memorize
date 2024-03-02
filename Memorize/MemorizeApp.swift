//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Teodor Adrian on 2/26/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
