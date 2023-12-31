//
//  ContentView.swift
//  Memorize
//
//  Created by Саша Восколович on 18.12.2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                Text("\(viewModel.nameOfTheme)")
                Spacer()
                Text("Score: \(viewModel.score)")
            }
            .font(.largeTitle)
            .foregroundStyle(.cyan)
            .padding()
            
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("New Game") {
                viewModel.new()
            }
            .font(.title)
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card, colorGradient: viewModel.colorOfTheme)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundStyle(viewModel.colorOfTheme)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
