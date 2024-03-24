//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Teodor Adrian on 3/23/24.
//

import SwiftUI

struct ThemeChooser: View {
    @ObservedObject var store: ThemeLibrary
    @State private var selectedThemeID: UUID?
    @State private var showEditor = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach (store.themes) { theme in
                    NavigationLink(destination: {
                        withAnimation(.snappy) {
                            EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))
                        }
                    }, label: {
                        listOfThemes(theme)
                    })
                }
                .onDelete { indexSet in
                    withAnimation {
                        store.themes.remove(atOffsets: indexSet)
                    }
                }
                .onMove{ indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            .navigationTitle(store.name)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    addButton
                }
            }
        }
        .tint(.black)
        .sheet(isPresented: $showEditor) {
            if let selectedTheme = selectedThemeID {
                ThemeEditor(theme: $store.themes[getThemeWithID(by: selectedTheme)])
            }
        }
    }
    
    var addButton: some View {
        Button {
            store.themes.append(Theme(name: "New", emojis: ["🆕"], color: .init(color: .red)))
            selectedThemeID = store.themes.last?.id
            showEditor = true
        } label: {
            Image(systemName: "plus")
        }
    }
    
    func listOfThemes(_ theme: Theme) -> some View {
        VStack(alignment: .leading) {
            Text(theme.name)
                .foregroundStyle(Color.init(rgba: theme.color))
                .font(.title)
                .bold()
            Text(theme.arrayToString(theme.emojis)).lineLimit(1)
            Text("Number of cards: \(theme.numberOfCards)")
                .font(.footnote)
        }
        .contextMenu {
            editButton(for: theme)
        }
    }
    
    func getThemeWithID(by id: UUID) -> Int {
        guard let index = store.themes.firstIndex(where: { $0.id == id }) else {
            fatalError("error")
        }
        return index
    }
    
    func editButton(for theme: Theme) -> some View {
        Button {
            selectedThemeID = theme.id
            showEditor = true
        } label: {
            HStack{
                Text("Edit")
                Image(systemName: "pencil")
            }
        }
    }
}

#Preview {
    ThemeChooser(store: ThemeLibrary(named: "Your Themes"))
}
