//
//  ContentView.swift
//  Memorize
//
//  Created by Teodor Adrian on 2/26/24.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String] = ["🦭", "🦋", "🐌", "🦖", "🦇", "🐕", "🦫", "🐝", "🦎", "🐀", "🐍", "🐊", "🤡",
                                   "🦭", "🦋", "🐌", "🦖", "🦇", "🐕", "🦫", "🐝", "🦎", "🐀", "🐍", "🐊"]
    
    let animals = ["🦭", "🦋", "🐌", "🦖", "🦇", "🐕", "🦫", "🐝", "🦎", "🦘", "🐀", "🐪", "🤡",
                  "🦭", "🦋", "🐌", "🦖", "🦇", "🐕", "🦫", "🐝", "🦎", "🦘", "🐀", "🐪"]
    
    let foods = ["🌭", "🍔", "🍟", "🍕", "🌮", "🌯", "🥗", "🥘", "🍣", "🍯", "🍚", "🥮", "🤡",
                 "🌭", "🍔", "🍟", "🍕", "🌮", "🌯", "🥗", "🥘", "🍣", "🍯", "🍚", "🥮"]
    
    let faces = ["😆", "🥹", "🤓", "😎", "🥰", "🤨", "🤯", "😤", "😭", "🫠", "🥱", "🤠", "🤡",
                 "😆", "🥹", "🤓", "😎", "🥰", "🤨", "🤯", "😤", "😭", "🫠", "🥱", "🤠"]
    
    @State var color: Color = .white
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .bold()
                .monospaced()
                .foregroundStyle(.black)
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
        LazyVGrid(columns: [GridItem(.adaptive (minimum: 60))]) {
            ForEach(0 ..< emojis.count, id: \.self) { index in
                CardView(emoji: emojis[index], themeColor: $color)
                    .aspectRatio(2/3, contentMode: .fit)
            }
            .onAppear {
                emojis.shuffle()
            }
        }.foregroundStyle(.quaternary)
    }
    
    var themeChooser: some View {
        VStack{
            HStack(spacing: 75){
                animalsThemeBtn
                foodsThemeBtn
                emojisThemeBtn
            }
            .font(.largeTitle)
            HStack(spacing: 65){
                Text("Animals")
                Text("Foods")
                Text("Emojis")
            }
            .foregroundStyle(.blue)
        }
    }
    
    func changeCards(theme name: String, emojisArray: [String], themeColor: Color) -> some View {
        return Button(action: {
            emojis.removeAll()
            emojis.append(contentsOf: emojisArray)
            emojis.shuffle()
            color = themeColor
        }, label: {
            Image(systemName: name)
        })
    }
    
    var animalsThemeBtn: some View {
        return changeCards(theme: "dog.fill", emojisArray: animals, themeColor: .white)
    }
    
    var foodsThemeBtn: some View {
        return changeCards(theme: "fork.knife", emojisArray: foods, themeColor: .brown)
    }
    
    var emojisThemeBtn: some View {
        return changeCards(theme: "smiley", emojisArray: faces, themeColor: .clear)
    }

}

// structura de tip View care imi face un card, are 2 proprietati: emojiul si daca este sau nu intoarsa
struct CardView: View {
    let emoji: String
    @State var isFacedUp: Bool = false // @State e un fel de pointer care ma lasa sa modific variabila
    @Binding var themeColor: Color
    
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 10) // baza, un dreptunghi cu corner radius de 40
        // ZStackul adica 2 dreptunghiuri suprapuse, unul alb si celalat peste el care e borderul
        // apoi Emojiul
        // opacitatea o setez daca e sau nu cu fata in sus
        ZStack {
            Group {
                base.fill(themeColor)
                base.strokeBorder(lineWidth: 3)
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
