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
        switch theme.color {
        case "blue": return .blue
        case "red": return .red
        case "orange": return .orange
        case "purple": return .purple
        case "pink": return .pink
        case "green": return .green
        case "brown": return .brown
        case "cyan": return .cyan
        case "indigo": return .indigo
        case "mint": return .mint
        case "white": return .white
        default: return .gray
        }
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

// TODO: Redesign app architecture to include HW6. Kinda wanna do this TBH.
