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
            VStack {
                Text("Memorize \(viewModel.themeName)!")
                    .font(.largeTitle)
                    .bold()
                    .monospaced()
                    .foregroundStyle(.black)
                    .aspectRatio(contentMode: .fill)
                if (!viewModel.gameOver){
                    Text("Score: \(viewModel.score)")
                        .bold()
                        .monospaced()
                }
            }
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            VStack {
                HStack{
                    newGame
                }
                themePicker
            }
        }
        .padding()
        .background(viewModel.color)
    }
    
    var cards: some View {
        Group{
            if viewModel.gameOver {
                Text("congrats! your final score is \(viewModel.score)")
                    .bold()
                    .monospaced()
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(50)
                
            } else {
                LazyVGrid(columns: [GridItem(.adaptive (minimum: 85), spacing: 0)], spacing: 0) {
                    ForEach(viewModel.cards) { card in
                        CardView(card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .padding(4)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }.foregroundStyle(.quaternary)
            }
        }
    }
    
    func changeTheme(_ newTheme: String) -> some View {
        Button(action: {
            viewModel.changeTheme(theme: newTheme)
        }, label: {
            Image(systemName: newTheme).font(.largeTitle)
        })
    }
    
    var themePicker: some View {
        HStack (spacing: 20) {
            animalsTheme
            foodTheme
            facesTheme
            sportsTheme
            vehiclesTheme
            flagsTheme
        }.foregroundStyle(.black)
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
    
    var sportsTheme: some View {
        changeTheme("soccerball")
    }
    
    var vehiclesTheme: some View {
        changeTheme("car.fill")
    }
    
    var flagsTheme: some View {
        changeTheme("flag.fill")
    }
    
    var newGame: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(minWidth: 0, maxWidth: 110, minHeight: 0, maxHeight: 40)
                .foregroundStyle(.black)
            Button(action: {
                viewModel.startNewGame()
            }, label: {
                Text("New Game")
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
            }).padding()
        }
    }
}

// structura de tip View care imi face un card, are 2 proprietati: emojiul si daca este sau nu intoarsa
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 35) // baza, un dreptunghi cu corner radius de 40
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
        .opacity(card.isFacedUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
