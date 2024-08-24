//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Anshu Vij on 24/08/24.
//

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    
    private static let emojis = ["👻", "🎃", "😈", "🕷️","👻", "🎃", "😈", "🕷️"]
    
    private static func createMemoryGame() -> MemorizeGame<String> {
        return MemorizeGame(numberOfPairsOfCards: 8) { pairIndex  in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }
            else {
                return "⁉️"
            }
       }
    }
    
    @Published private var model  = createMemoryGame()

    var cards : [MemorizeGame<String>.Card] {
        return model.cards
    }
    
    func chose(_ card : MemorizeGame<String>.Card) {
        model.choose(card)
    }
    // MARK: - Intent
    
    func shuffle() {
        model.shuffle()
    }
}
