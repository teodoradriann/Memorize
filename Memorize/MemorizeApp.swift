//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Teodor Adrian on 2/26/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var themeChooser = ThemeLibrary(named: "Your Themes")
    var body: some Scene {
        WindowGroup {
            ThemeChooser(store: themeChooser)
        }
    }
}
