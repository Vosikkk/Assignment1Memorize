//
//  Theme.swift
//  Memorize
//
//  Created by Саша Восколович on 18.12.2023.
//

import Foundation

struct Theme {
   
    let name: String
    let emojis: [String]
    let color: String
    let numbersOfPairs: Int?
    
    
    init(name: String, emojis: [String], color: String, numbersOfPairs: Int? = nil) {
        self.name = name
        self.emojis = emojis
        self.color = color
        self.numbersOfPairs = numbersOfPairs == nil ? Int.random(in: 0..<emojis.count) : numbersOfPairs
    }
    
    
    func calculatePairs() -> Int {
        return min(emojis.count, numbersOfPairs!)
    }
}
