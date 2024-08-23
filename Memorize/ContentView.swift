//
//  ContentView.swift
//  Memorize
//
//  Created by Anshu Vij on 22/08/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "😈", "🕷️","👻", "🎃", "😈", "🕷️"]
    @State var cardCount = 4
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardsAdjuster
            
        }
        
        .padding()
    }
    
    var cardsAdjuster : some View {
        HStack {
            
            cardRemover
            Spacer()
            cardAdder
            
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cards : some View {
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }
    
    var cardAdder : some View {
        return cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus")
    }
    
    var cardRemover : some View {
       return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus")
    }
    
    func cardCountAdjuster(by offset : Int, symbol : String) -> some View {
        
        Button(action: {
            cardCount += offset
        }, label: {
          Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
}

struct CardView : View {
    let content : String
    @State var isFaceUp : Bool = true
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                   base.foregroundStyle(.white)
                   base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            } .opacity( isFaceUp ? 1 : 0)
            base.fill().opacity( isFaceUp ? 0 : 1)
            
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
