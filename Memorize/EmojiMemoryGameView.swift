//
//  ContentView.swift
//  Memorize
//
//  Created by Саша Восколович on 18.12.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
   
    private let spasing: CGFloat = 4
    
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
            
            newGame
                .font(.title)
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spasing)
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
        }
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
    
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
