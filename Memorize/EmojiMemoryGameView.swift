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
                Text("\(viewModel.nameOfTheme)")
                Spacer()
                Text("Score: \(viewModel.score)")
            }
            .font(.largeTitle)
            .foregroundStyle(.cyan)
            .padding()
            
          //  ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
          //  }
            Button("New Game") {
                viewModel.new()
            }
            .font(.title)
        }
        .padding()
    }
    
    var cards: some View {
       
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spasing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        
        /// If we want to work with scroll, and have the same size for each card
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
//                ForEach(viewModel.cards) { card in
//                    CardView(card, colorGradient: viewModel.colorOfTheme)
//                        .aspectRatio(aspectRatio, contentMode: .fit)
//                        .padding(spasing)
//                        .onTapGesture {
//                            viewModel.choose(card)
//                        }
//                }
//            }
            .foregroundStyle(viewModel.colorOfTheme)
        }
    
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
