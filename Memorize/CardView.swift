//
//  CardView.swift
//  Memorize
//
//  Created by Саша Восколович on 31.12.2023.
//

import SwiftUI

typealias Card = MemoryGame<String>.Card

struct CardView: View {
    
    let card: Card
    let colorGradient: Color
    
    init(_ card: Card, colorGradient: Color) {
        self.card = card
        self.colorGradient = colorGradient
    }
   
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.inset)
            )
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants {
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
}

#Preview {
    HStack {
        CardView(Card( isFaceUp: true, content: "X"), colorGradient: .red)
        CardView(Card(content: "X"), colorGradient: .red)
    }
}
