//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Teodor Adrian on 3/23/24.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    @State private var emojisToAdd: String = ""
    @State private var color = Color.clear
    private let emojiFont = Font.system(size: 50)
    
    var body: some View {
        Form {
            nameOfTheme
            currentEmojis
            addEmojis
            changeNumberOfVisibleCards
            changeColor
        }
        .onAppear{
            color = Color(rgba: theme.color)
        }
    }
    
    var changeNumberOfVisibleCards: some View {
        Section {
            Stepper("Cards in game: \(theme.numberOfCards)") {
                if (theme.numberOfCards < theme.emojis.count){
                    theme.numberOfCards += 1
                }
            } onDecrement: {
                if (theme.numberOfCards > 2){
                    theme.numberOfCards -= 1
                }
            }
        } header: {
            Text("Change the number of playing cards")
        }
        
    }
    
    var changeColor: some View {
        Section {
            ColorPicker(selection: $color, label: {
                Text("Pick a color 🎨")
            }).onChange(of: color) {
                theme.color = RGBA(color: color)
            }
        } header: {
            Text("pick the theme color")
        }

    }
    
    var addEmojis: some View {
        Section {
            TextField("Emojis", text: $emojisToAdd)
                .onChange(of: emojisToAdd) {
                    let emoji = emojisToAdd.split(separator: "")
                    if !emoji.isEmpty {
                        if !theme.emojis.contains(String(emoji.last!)){
                            theme.emojis.append(String(emoji.last!))
                            theme.numberOfCards += 1
                        }
                    }
                }
        } header: {
            Text("Add Emojis Here")
        }
    }
    
    var nameOfTheme: some View {
        Section {
            TextField("Name", text: $theme.name).font(.title)
        } header: {
            Text("Name of the theme")
        }
    }
    
    var currentEmojis: some View {
        Section {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(theme.emojis, id: \.self) { emoji in
                    Text(emoji)
                        .font(emojiFont)
                        .onTapGesture {
                            if theme.emojis.count <= 2 {
                                return
                            }
                            if let index = theme.emojis.firstIndex(of: emoji) {
                                theme.emojis.remove(at: index)
                                theme.numberOfCards = theme.emojis.count
                            }
                        }
                }
            }
        } header: {
            Text("Current emojis")
        } footer: {
            Text("you can tap to an emoji to remove it").font(.caption).shadow(radius: 1)
        }
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    @State static var theme = Theme(name: "Animals", emojis: ["🦭", "🦋", "🐌", "🦖", "🦇", "🐕", "🦫", "🐝", "🦎", "🦘", "🐀", "🐪"], color: RGBA(color: .red))
    static var previews: some View {
        ThemeEditor(theme: $theme)
    }
}

