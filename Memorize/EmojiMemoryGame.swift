//
//  EmojiMemoryGame.swift
//  Memorize
//  ViewModel
//
//  Created by Joshua Galvan on 2/27/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static let transportation = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎️", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍️", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"]
    private static let sports = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳️", "🪁", "🏹", "🎣", "🥊"]
    private static let animals = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🦆", "🦅", "🦋"]
    private static let flags = ["🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇭", "🇧🇩", "🇧🇧", "🇧🇾", "🇧🇪", "🇧🇿", "🇺🇸"]
    private static let objects = ["📷", "📞", "☎️", "📺", "📻", "🧭", "🎛️", "⏰", "⏳", "📡", "🔋", "💡", "🛢️", "💵", "🧰", "🔧", "🧲", "⛓️", "🔫", "🧨", "⚔️", "🛡️", "💊", "🧽"]
    private static let food = ["🍏", "🍎", "🍐", "🍊", "🍇", "🍉", "🍌", "🍋", "🍓", "🫐", "🍒", "🥥", "🍍", "🍑", "🥝", "🍅", "🥑", "🥒", "🥦", "🌽", "🫑", "🫒", "🍞", "🥨"]

    private static var themes: [Theme<String>] = [
        .init(name: "Transportation", emojis: transportation, numberOfPairs: 18, color: "red"),
        .init(name: "Sports", emojis: sports, numberOfPairs: 10, color: "blue"),
        .init(name: "Animals", emojis: animals, numberOfPairs: 6, color: "mint"),
        .init(name: "Flags", emojis: flags, numberOfPairs: 15, color: "indigo"),
        .init(name: "Objects", emojis: objects, numberOfPairs: 8, color: "orange"),
        .init(name: "Food", emojis: food, numberOfPairs: 10, color: "gray")]

    static var numberOfThemes: Int {
        return themes.count
    }
    
    static var currentThemesIndex = 0
    
    static func addTheme(name: String, emojis: [String], numberOfPairs: Int, color: String) {
        themes.append(Theme(name: name, emojis: emojis, numberOfPairs: numberOfPairs, color: color))
    }
    
    private static func createMemoryGameWithTheme(_ theme: Theme<String>) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs, cardContents: theme.emojis.shuffled())
    }
    
    private static func chooseRandomTheme() -> Theme<String> {
        var randomIndex = Int.random(in: 0..<numberOfThemes)
        while currentThemesIndex == randomIndex {
            randomIndex = Int.random(in: 0..<numberOfThemes)
        }
        currentThemesIndex = randomIndex
        return themes[randomIndex]
    }
        
    init() {
        let thisTheme = EmojiMemoryGame.chooseRandomTheme()
        model = EmojiMemoryGame.createMemoryGameWithTheme(thisTheme)
        theme = thisTheme
    }
    
    @Published private var model: MemoryGame<String>
    private var theme: Theme<String>
    
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
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func updateRandomTheme() {
        theme = EmojiMemoryGame.chooseRandomTheme()
        model = EmojiMemoryGame.createMemoryGameWithTheme(theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
}

// TODO: Redesign app architecture to include HW6. Kinda wanna do this TBH.
