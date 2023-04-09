//
//  Theme.swift
//  Memorize
//  Model
//
//  Created by Joshua Galvan on 3/15/23.
//

import Foundation

struct Theme<CardContent>: Codable where CardContent: Codable {
    private(set) var name: String
    private(set) var emojis: [CardContent]
    private(set) var numberOfPairs: Int
    private(set) var color: String
    
    init(name: String, emojis: [CardContent], numberOfPairs: Int, color: String) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairs = numberOfPairs
        self.color = color
    }
}
