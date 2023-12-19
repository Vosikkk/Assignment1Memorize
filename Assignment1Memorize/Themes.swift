//
//  Themes.swift
//  Assignment1Memorize
//
//  Created by Саша Восколович on 18.12.2023.
//

import Foundation

struct Theme {
    // The name of the theme
    let name: String
    
    // An array of emojis corresponding to the theme
    let emoji: [String]
    
    // Our available tmemes
    static private let themes = [
                                  Theme(name: "animals", emoji: ["🐶", "🐱", "🐼", "🐸", "🐢", "🐯", "🦁", "🦊", "🦄"]),
                                  Theme(name: "planets", emoji: ["🌞","🌝","🌛","🌜","🌚","🌎","🌘"]),
                                  Theme(name: "food", emoji: ["🍕","🥖","🥐","🍤","🍖","🍔","🧀","🥩","🍨","🍭"]),
                                 
    ]
    
    
    //Here we received how many themes do we have
    static func getAmountOfThemes() -> Int {
        return themes.count
    }
    
    // Oy give me some emoji
    static func get(by themeIndex: Int) -> [String] {
        return themes[themeIndex].emoji
    }
    static func get(name byIndex: Int) -> String {
        return themes[byIndex].name
    }
}
