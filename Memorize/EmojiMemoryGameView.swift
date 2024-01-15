//
//  ContentView.swift
//  Memorize
//
//  Created by Саша Восколович on 18.12.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State private var dealt: Set<Card.ID> = []
    
    @State private var lastScoreChange = (0, cousedByCardId: UUID())
    
    @Namespace private var dealingNamesSpace
    
   
    var body: some View {
        VStack {
            HStack {
                nameOfTheme
                Spacer()
                score
            }
            .font(.largeTitle)
            .foregroundStyle(.cyan)
            .padding()
            
            cards
                .foregroundStyle(viewModel.colorOfTheme)
            HStack {
                newGame
                    .font(.title)
                Spacer()
                deck
                    .foregroundStyle(viewModel.colorOfTheme)
            }
        }
        .padding()
    }
    
    
    // MARK: - Support views
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: Constants.aspectRatio) { card in
            if isDealt(card) {
                view(for: card)
                    .padding(Constants.spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                
                // we want that numbers appear always in front
                    .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                    view(for: card)
            }
        }
        .frame(width: Constants.CardsSize.width, height: Constants.CardsSize.width / Constants.aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private func view(for card: Card) -> some View {
        CardView(card)
            .matchedGeometryEffect(id: card.id, in: dealingNamesSpace)
            .transition(.asymmetric(insertion: .identity, removal: .identity))
    }
    
    
    private var newGame: some View {
        Button("New Game") {
            withAnimation { 
                viewModel.new()
            }
        }
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var nameOfTheme: some View {
        Text("\(viewModel.nameOfTheme)")
    }
    
    
    
    // MARK: - Logic for views
    
    private func deal() {
        var delay: TimeInterval = 0
        
        for card in viewModel.cards {
            withAnimation(.easeInOut(duration: Constants.Animation.duration).delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += Constants.Animation.delay
        }
    }
    
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChange = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChange
            lastScoreChange = (scoreChange, card.id)
        }
    }
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2/3
        static let spacing: CGFloat = 4
        
        struct CardsSize {
            static let width: CGFloat = 50
        }
        
        struct Animation {
            static let delay: TimeInterval = 0.15
            static let duration: CGFloat = 1
        }
    }
    
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
