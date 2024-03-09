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
            if (!viewModel.gameOver){
                cards.animation(.default, value: viewModel.cards)
            }
            else {
                Spacer()
                gameOverScreen
                Spacer()
            }
            VStack(spacing: 35) {
                HStack{
                    newGame
                }
                themePicker
            }
        }
        .padding(40)
        .background(viewModel.color)
    }
    
    private var cards: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(count: viewModel.cards.count, size: geometry.size, atAspectRatio: aspectRatio)
            LazyVGrid(columns: [GridItem(.adaptive (minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }.foregroundStyle(.quaternary)
        }
    }
    
    private var gameOverScreen: some View {
        Text("Congrats!  Your final score is \(viewModel.score)")
            .bold()
            .monospaced()
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .padding(50)
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
            viewModel.changeTheme(theme: newTheme)
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
                viewModel.startNewGame()
            }, label: {
                Text("New Game")
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
            }).padding()
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
