//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Anshu Vij on 24/08/24.
//
import Foundation


struct MemorizeGame<CardContent> where CardContent : Equatable  {
    
  private(set) var cards : [Card]
    private(set) var score : Int = 0
    
    init(numberOfPairsOfCards : Int, cardContentFactory : (Int) -> CardContent ) {
        cards = []
        //add number of pairsofCards * 2 cards
        
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: "\(pairIndex + 1)a", content: content))
            cards.append(Card(id: "\(pairIndex + 1)b", content: content))
        }
        
    }
    
    var indexOfOneAndOneFaceUpCard : Int? {
        get {
            return cards.indices.filter { index in cards[index].isFaceUp}.only
        }
        
        set {
             cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)}
            
        }
    }
    
    mutating func choose(_ card : Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialIndex = indexOfOneAndOneFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialIndex].isMatched = true
                        score += 2
                    } else {
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                }
                else {
                    indexOfOneAndOneFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
    
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card : Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            return "\(id) : \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "") "
        }
        var id : String
        var isFaceUp : Bool = false {
            didSet {
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var hasBeenSeen : Bool = false
        var isMatched : Bool = false
        let content : CardContent
    }
}

extension Array {
    var only : Element? {
        return count == 1 ? first : nil
    }
}
