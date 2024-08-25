//
//  CardView.swift
//  Memorize
//
//  Created by Anshu Vij on 25/08/24.
//

import SwiftUI

struct CardView : View {
    let card : MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    var body: some View {
        TimelineView(.animation) { timeline in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(240))
                    .opacity(0.4)
                    .overlay(
                        Text(card.content)
                            .font(.system(size: 200))
                            .minimumScaleFactor(0.01)
                            .multilineTextAlignment(.center)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(5)
                            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                            .animation(.spin(duration: 1), value: card.isMatched)
                    )
                    .padding(5)
                    .cardify(isFaceUp: card.isFaceUp)
            }
               
        }
    }
}


#Preview {
    typealias Card = MemorizeGame<String>.Card
   return VStack {
        HStack {
            CardView(Card(id: "test1", isFaceUp:  true, content: "X"))
            CardView(Card(id: "test1", isFaceUp: false, isMatched: false, content: "X"))
        }
            HStack {
                CardView(Card(id: "test1", content: "X"))
                CardView(Card(id: "test1", isFaceUp: true, isMatched: false, content: "This is a very long string and I hope it fits"))
            }
        }
        .padding()
        .foregroundStyle(.green)
    
}
extension Animation {
    static func spin(duration : TimeInterval) -> Animation {
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
}
