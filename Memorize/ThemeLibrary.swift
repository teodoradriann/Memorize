//
//  ThemeStore.swift
//  Memorize
//
//  Created by Teodor Adrian on 3/23/24.
//

import SwiftUI

class ThemeLibrary: ObservableObject, Identifiable {
    
    let name: String
    var id: String { name }
    
    @Published var themes = [Theme]() {
        didSet {
            autosave()
        }
    }
    
    private let autosaveURL = URL.documentsDirectory.appendingPathComponent("Themes.txt")
    
    private func autosave(){
        save(to: autosaveURL)
        print(autosaveURL)
    }
    
    private func save(to url: URL){
        do {
            let data = try JSONEncoder().encode(themes)
            try data.write(to: url)
            print("saving")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    init(named name: String) {
        self.name = name
        if let data = try? Data(contentsOf: autosaveURL) {
            if let savedThemes = try? JSONDecoder().decode([Theme].self, from: data) {
                themes = savedThemes
                print(themes)
            }
        }
        
        if themes.isEmpty {
            themes = Theme.builtins
        }
    }
}
