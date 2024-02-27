//
//  ContentView.swift
//  Memorize
//
//  Created by Teodor Adrian on 2/26/24.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String] = ["🦭", "🦋", "🐌", "🦖", "🦇", "🐕", "🦫", "🐝", "🦎", "🦘", "🐀", "🐪",
                                   "🦭", "🦋", "🐌", "🦖", "🦇", "🐕", "🦫", "🐝", "🦎", "🦘", "🐀", "🐪"]
    
    let foods = ["🌭", "🍔", "🍟", "🍕", "🌮", "🌯", "🥗", "🥘", "🍣", "🍯", "🍚", "🥮",
                 "🌭", "🍔", "🍟", "🍕", "🌮", "🌯", "🥗", "🥘", "🍣", "🍯", "🍚", "🥮"]
    
    let faces = ["😆", "🥹", "🤓", "😎", "🥰", "🤨", "🤯", "😤", "😭", "🫠", "🥱", "🤠",
                 "😆", "🥹", "🤓", "😎", "🥰", "🤨", "🤯", "😤", "😭", "🫠", "🥱", "🤠"]
    
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .bold()
                .monospaced()
            ScrollView{
                cards
            }
            Spacer()
            themeChooser
        }
        .padding()
        .background(Color.gray)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive (minimum: 120))]) {
            ForEach(0 ..< emojis.count, id: \.self) { index in
                CardView(emoji: emojis[index]).aspectRatio(1.5, contentMode: .fill)
            }
            .onAppear {
                emojis.shuffle()
            }
        }.foregroundStyle(.quaternary)
    }
    
    var themeChooser: some View {
        HStack(spacing: 75){
            animalsThemeBtn
            foodsThemeBtn
            emojisThemeBtn
        }
        .font(.largeTitle)
    }
    
    func changeCards(theme name: String, emojis: [String]) -> some View {
        Button(action: {
            switch name {
            case "dog.fill":
                print("animals")
            case "fork.knife":
                print("foods")
            case "smiley":
                print("faces")
            default:
                print("error")
            }
        }, label: {
            Image(systemName: name)
        })
    }
    
    var animalsThemeBtn: some View {
        changeCards(theme: "dog.fill", emojis: emojis)
    }
    
    var foodsThemeBtn: some View {
        changeCards(theme: "fork.knife", emojis: foods)
    }
    
    var emojisThemeBtn: some View {
        changeCards(theme: "smiley", emojis: faces)
    }
}

// structura de tip View care imi face un card, are 2 proprietati: emojiul si daca este sau nu intoarsa
struct CardView: View {
    let emoji: String
    @State var isFacedUp = true // @State e un fel de pointer care ma lasa sa modific variabila
    
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 20) // baza, un dreptunghi cu corner radius de 40
        // ZStackul adica 2 dreptunghiuri suprapuse, unul alb si celalat peste el care e borderul
        // apoi Emojiul
        // opacitatea o setez daca e sau nu cu fata in sus
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 4)
                Text(emoji).font(.largeTitle)
            }
            .opacity(isFacedUp ? 1 : 0)
            base.fill().opacity(isFacedUp ? 0 : 1)
        }
        .onTapGesture {
            isFacedUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
