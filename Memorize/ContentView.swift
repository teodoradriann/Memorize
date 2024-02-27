//
//  ContentView.swift
//  Memorize
//
//  Created by Teodor Adrian on 2/26/24.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["🦭", "🦋", "🐌", "🦖", "🦇", "🐕", "🦫", "🐝", "🦎", "🦘", "🐀"]
    @State var cardCounter = 4
    
    var body: some View {
        VStack {
            ScrollView{
                cards
            }
            Spacer()
            cardsAdjusters
        }
        .padding()
        .background(Color.gray)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive (minimum: 120))]) {
            ForEach(0 ..< cardCounter, id: \.self) { index in
                CardView(emoji: emojis[index]).aspectRatio(contentMode: .fit)
            }
        }.foregroundStyle(.quaternary)
    }
    
    //functie care ajusteaza numarul cardurilor conform unui numar si returneaza un buton
    func adjustCards(by number: Int, nameOfAdjuster: String) -> some View {
        Button(action: {
            cardCounter += number
        }, label: {
            Image(systemName: nameOfAdjuster)
                .font(.largeTitle)
                .foregroundStyle(.white)
        }).disabled(cardCounter + number < 1 || cardCounter + number > emojis.count)
    }
    
    var buttonsBackround: some View {
        Rectangle()
    }
    
    var cardsAdjusters: some View {
        HStack{
            cardAdder
            Spacer().frame(maxWidth: 150)
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

// structura de tip View care imi face un card, are 2 proprietati: emojiul si daca este sau nu intoarsa
struct CardView: View {
    let emoji: String
    @State var isFacedUp = true // @State e un fel de pointer care ma lasa sa modific variabila
    
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 40) // baza, un dreptunghi cu corner radius de 40
        // ZStackul adica 2 dreptunghiuri suprapuse, unul alb si celalat peste el care e borderul
        // apoi Emojiul
        // opacitatea o setez daca e sau nu cu fata in sus
        ZStack {
            Group {
                base.fill(.white)
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
