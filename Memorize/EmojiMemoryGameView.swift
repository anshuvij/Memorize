//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Anshu Vij on 22/08/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemorizeGame<String>.Card
    @ObservedObject var viewModel : EmojiMemoryGame
    private let aspectRatio :  CGFloat = 2/3
    
    var body: some View {
        VStack {
            cards
            HStack {
                score
                Spacer()
                shuffle
                
            }.font(.largeTitle)
        }
        .padding()
    }
    
    private var score : some View {
        Text("Score : \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle : some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    var cards : some View {
        AspectVGrid(items : viewModel.cards, aspectRatio : aspectRatio) { card in
            CardView(card)
                .padding(4)
                .overlay (
                    FlyingNumber(number : scoreChanged(causedBy : card))
                ).zIndex(scoreChanged(causedBy: card) != 0 ? 100 : 0)
                .onTapGesture {
                    choose(card)
                }
        }
        .foregroundStyle(.orange)
    }
    
    private func choose( _ card : Card) {
        withAnimation(.easeInOut(duration: 1)) {
            let scoreBeforeScoring = viewModel.score
            viewModel.chose(card)
            let scoreChanged = viewModel.score - scoreBeforeScoring
            lastScoreChanges = (scoreChanged, causedById : card.id)
            
        }
    }
    @State private var lastScoreChanges  = (0, causedById : "")
    private func scoreChanged(causedBy card : Card) -> Int {
        let (amount, id) = lastScoreChanges
        return card.id == id ? amount : 0
    }
    
}
#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
