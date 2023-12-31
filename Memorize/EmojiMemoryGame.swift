//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Саша Восколович on 23.12.2023.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var game: MemoryGame<String>
    
    var cards: [Card] {
        return game.cards
    }
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        return MemoryGame(pairsOfCards: theme.calculatePairs(), cardContentFactory: {
            return theme.emojis[$0]
        })
    }
    
    
    var colorOfTheme: Color {
        switch currentTheme.color {
        case "blue":
            return .blue
        case "yellow":
            return .yellow
        case "green":
            return .green
        case "cyan":
            return .cyan
        case "orange":
            return .orange
        case "purple":
            return .purple
        default: return .red
        }
    }
    
    var score: Int {
        return game.score
    }
    
    var nameOfTheme: String {
        return currentTheme.name
    }
    
    private var currentTheme: Theme
    
    
    init() {
        currentTheme = themes.randomElement() ?? themes[0]
        game = EmojiMemoryGame.createMemoryGame(theme: currentTheme)
    }
    
    
    func new() {
        currentTheme = themes.randomElement() ?? themes[0]
        game = EmojiMemoryGame.createMemoryGame(theme: currentTheme)

    }

    // MARK: - Intents
    
    
    func shuffle() {
        game.shuffle()
    }
    
    func choose(_ card: Card) {
        game.choose(card)
    }
    
    
    
    private let themes = [
       Theme(
        name: "Animals",
        emojis: ["🐶", "🐱", "🐼", "🐸", "🐢", "🐯", "🦁", "🦊", "🦄"],
        color: "green"),
       
       Theme(
        name: "Planets",
        emojis: ["🌞","🌝","🌛","🌜","🌚","🌎","🌘"],
        color: "blue",
        numbersOfPairs: 8),
       
       Theme(
        name: "Food",
        emojis: ["🍕","🥖","🥐","🍤","🍖","🍔","🧀","🥩","🍨","🍭"],
        color: "yellow",
        numbersOfPairs: 15),
       
       Theme(
        name: "Drinks",
        emojis:  ["🥛","🍼","🥂","🍷","🍻","🍹","🍸","🍺","☕️","🧋","🥤"],
        color: "cyan",
        numbersOfPairs: 8),
       
       Theme(
        name: "Nature",
        emojis: ["🌳","🪴","🌹","☘️","🌿","🎄","🍀","🌾","🌺","🥀"],
        color: "orange",
        numbersOfPairs: 9),
       
       Theme(
        name: "Fruit",
        emojis: ["🍎", "🍌", "🍇", "🍊", "🍓", "🍍", "🍑", "🍒", "🍉", "🥝"],
        color: "purple",
        numbersOfPairs: 9),
    ]
    
}
