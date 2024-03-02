//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Teodor Adrian on 2/26/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
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
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(minWidth: 0, maxWidth: 80, minHeight: 0, maxHeight: 40)
                        .foregroundStyle(.blue)
                    Button(action: {
                        viewModel.shuffle()
                    }, label: {
                        Text("Shuffle")
                            .foregroundStyle(.white)
                            .font(.system(size: 18))
                    }).padding()
                }
                themePicker
            }
        }
        .padding()
        .background(Color.gray)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive (minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }.foregroundStyle(.quaternary)
    }
    
    func changeTheme(_ newTheme: String) -> some View {
        Button(action: {
            viewModel.changeTheme(theme: newTheme)
        }, label: {
            Image(systemName: newTheme).font(.largeTitle)
        })
    }
    
    var themePicker: some View {
        HStack (spacing: 50) {
            animalsTheme
            foodTheme
            facesTheme
        }
    }
    
    var animalsTheme: some View {
        changeTheme("dog.fill")
    }
    
    var foodTheme: some View {
        changeTheme("carrot.fill")
    }
    
    var facesTheme: some View {
        changeTheme("smiley.fill")
    }
}

// structura de tip View care imi face un card, are 2 proprietati: emojiul si daca este sau nu intoarsa
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 10) // baza, un dreptunghi cu corner radius de 40
        // ZStackul adica 2 dreptunghiuri suprapuse, unul alb si celalat peste el care e borderul
        // apoi Emojiul
        // opacitatea o setez daca e sau nu cu fata in sus
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(card.content).font(.system(size: 100)).minimumScaleFactor(0.01).aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFacedUp ? 1 : 0)
            base.fill().opacity(card.isFacedUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
