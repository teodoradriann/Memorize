//
//  ContentView.swift
//  Memorize
//
//  Created by Teodor Adrian on 2/26/24.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["🦭", "🦋", "🐌", "🦖", "🦇", "🐕", "🦫"]
    @State var cardCounter = 3
    
    var body: some View {
        ScrollView {
            cards
            Spacer()
            cardsAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        HStack {
            ForEach(0 ..< cardCounter, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }.foregroundStyle(.brown)
    }
    
    func adjustCards(by number: Int, nameOfAdjuster: String) -> some View {
        Button(action: {
            cardCounter += number
        }, label: {
            Image(systemName: nameOfAdjuster)
        }).disabled(cardCounter + number < 1 || cardCounter + number > emojis.count)
    }
    
    var cardsAdjusters: some View {
        HStack{
            cardAdder
            Spacer()
            cardRemover
        }
    }
    
    var cardAdder: some View {
        adjustCards(by: +1, nameOfAdjuster: "plus")
    }
    
    var cardRemover: some View {
        adjustCards(by: -1, nameOfAdjuster: "minus")
    }
}
struct CardView: View {
    let content: String
    @State var isFacedUp = true
    
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 10)
        
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            .opacity(isFacedUp ? 1 : 0)
            base.fill().opacity(isFacedUp ? 0 : 1)
        }.onTapGesture {
            isFacedUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
