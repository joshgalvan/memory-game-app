//
//  EmojiMemoryGame.swift
//  Memorize
//  ViewModel
//
//  Created by Joshua Galvan on 2/27/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    private static func createMemoryGameWithTheme(_ theme: Theme<String>) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs, cardContents: theme.emojis.shuffled())
    }
        
    init(theme: Theme<String>) {
        self.model = EmojiMemoryGame.createMemoryGameWithTheme(theme)
        self.theme = theme
    }
    
    @Published private var model: MemoryGame<String>
    @Published private var theme: Theme<String> {
        didSet {
            if self.theme != oldValue {
                restart()
            }
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var color: Color {
        theme.UIColor
    }
    
    var score: Int {
        model.score
    }
    
    var themeName: String {
        theme.name
    }
    
    // MARK: - Intent(s)
    
    func restart() {
        self.model = EmojiMemoryGame.createMemoryGameWithTheme(self.theme)
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }

    func shuffle() {
        model.shuffle()
    }
}
