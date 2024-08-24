//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Anshu Vij on 22/08/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel : EmojiMemoryGame
    private let aspectRatio :  CGFloat = 2/3
    var body: some View {
        VStack {
                cards
                    .animation(.default, value: viewModel.cards)
            
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    var cards : some View {
        AspectVGrid(items : viewModel.cards, aspectRatio : aspectRatio) { card in
                        CardView(card)
                            .padding(4)
                            .onTapGesture {
                                viewModel.chose(card)
                            }
        }
        .foregroundStyle(.orange)
    }
    
}

struct CardView : View {
    let card : MemorizeGame<String>.Card
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                   base.foregroundStyle(.white)
                   base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            } .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            
        }.opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
