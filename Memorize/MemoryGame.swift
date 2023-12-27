//
//  MemoryGame.swift
//  Memorize
//
//  Created by Саша Восколович on 23.12.2023.
//

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: [Card]
    
    private(set) var score: Int = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue } }
    }
    
    init(pairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, pairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        shuffle()
    }
    
    
    mutating func choose(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }), !card.isFaceUp, !card.isMatched {
            if let potentialMatchedIndex = indexOfOneAndOnlyFaceUpCard {
                cards[index].hasAlreadyBeenSeen += 1
                cards[potentialMatchedIndex].hasAlreadyBeenSeen += 1
                if card.content == cards[potentialMatchedIndex].content {
                    cards[potentialMatchedIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[index].hasAlreadyBeenSeen > 1 || cards[potentialMatchedIndex].hasAlreadyBeenSeen > 1 {
                        score -= 1  // dismatch
                    }
                }
                // open second card
                cards[index].isFaceUp.toggle()
                
            } else {
                // open card(will be open alone :)) )
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
  
    struct Card: Identifiable, Equatable {
        var id = UUID()
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var hasAlreadyBeenSeen: Int = 0
    }
}

extension Array {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
