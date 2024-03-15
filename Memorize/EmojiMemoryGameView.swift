//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Teodor Adrian on 2/26/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio : CGFloat = 2/3
    typealias Card = MemoryGame<String>.Card
    
    var body: some View {
        VStack {
            VStack {
                Text("Memorize \(viewModel.themeName)!")
                    .font(.title)
                    .bold()
                    .monospaced()
                    .foregroundStyle(.black)
                    .aspectRatio(contentMode: .fill)
                if (!viewModel.gameOver){
                    Text("Score: \(viewModel.score)")
                        .bold()
                        .monospaced()
                        .foregroundStyle(.black)
                        .animation(nil)
                }
            }
            if (!viewModel.gameOver){
                cards
                    .padding(.leading)
                    .padding(.trailing)
            }
            else {
                Spacer()
                gameOverScreen
                Spacer()
            }
            VStack(spacing: 35) {
                HStack(spacing: 35){
                    newGame.padding(.leading)
                    deck
                    shuffle.padding(.trailing)
                    
                }
                themePicker
            }
        }
        .background(viewModel.color)
        
    }
    
    private var cards: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(count: viewModel.cards.count, size: geometry.size, atAspectRatio: aspectRatio)
            LazyVGrid(columns: [GridItem(.adaptive (minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    if isDealt(card){
                        CardView(card)
                            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                            .transition(.asymmetric(insertion: .identity, removal: .identity))
                            .aspectRatio(aspectRatio, contentMode: .fit)
                            .padding(4)
                            .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                            .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0)
                            .transition(.scale)
                            .onTapGesture {
                                choose(card)
                            }
                    }
                    
                }
            }.foregroundStyle(.quaternary)
            
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    private var undealtCards: [Card] {
        viewModel.cards.filter( { !isDealt($0) })
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack{
            ForEach(undealtCards){ card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: 50, height: 50 / aspectRatio)
        .foregroundStyle(.black)
        .onTapGesture {
            var delay: TimeInterval = 0
            for card in viewModel.cards {
                withAnimation(.easeInOut(duration: 1).delay(delay)){
                    _ = dealt.insert(card.id)
                }
                delay += 0.25
            }
        }
    }
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, card.id)
        }
    }
    
    @State private var lastScoreChange: (_: Int, causedByCardId: Card.ID) = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
    private var gameOverScreen: some View {
        Text("Congrats!\nYour final score is \(viewModel.score)")
            .bold()
            .monospaced()
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .padding(100)
    }
    
    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / atAspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            else {
                columnCount += 1
            }
        } while columnCount < count
        
        return min(size.width / count, size.height * atAspectRatio).rounded(.down)
    }
    
    func changeTheme(_ newTheme: String) -> some View {
        Button(action: {
            dealt = []
            withAnimation {
                viewModel.changeTheme(theme: newTheme)
            }
            
        }, label: {
            Image(systemName: newTheme).font(.largeTitle)
        })
    }
    
    private var themePicker: some View {
        HStack (spacing: 20) {
            animalsTheme
            foodTheme
            facesTheme
            sportsTheme
            vehiclesTheme
            flagsTheme
        }.foregroundStyle(.black)
    }
    
    private var animalsTheme: some View {
        changeTheme("dog.fill")
    }
    
    private var foodTheme: some View {
        changeTheme("carrot.fill")
    }
    
    private var facesTheme: some View {
        changeTheme("smiley.fill")
    }
    
    private var sportsTheme: some View {
        changeTheme("soccerball")
    }
    
    private var vehiclesTheme: some View {
        changeTheme("car.fill")
    }
    
    private var flagsTheme: some View {
        changeTheme("flag.fill")
    }
    
    private var newGame: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(minWidth: 0, maxWidth: 110, minHeight: 0, maxHeight: 40)
                .foregroundStyle(.black)
            Button(action: {
                dealt = []
                withAnimation {
                    viewModel.startNewGame()
                }
                
            }, label: {
                Text("New Game")
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
            })
        }
    }
    private var shuffle: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(minWidth: 0, maxWidth: 110, minHeight: 0, maxHeight: 40)
                .foregroundStyle(.black)
            Button(action: {
                withAnimation {
                    viewModel.shuffle()
                }
            }, label: {
                Text("Shuffle")
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
            })
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
