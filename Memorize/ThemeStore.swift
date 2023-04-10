//
//  ThemeStore.swift
//  Memorize
//
//  Created by Joshua Galvan on 4/9/23.
//

import SwiftUI

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

class ThemeStore: ObservableObject {
    @Published var themes = [Theme<String>]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "EmojiMemoryGame/ThemeStore"
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode([Theme<String>].self, from: jsonData) {
            self.themes = decodedThemes
        }
    }
    
    init() {
        restoreFromUserDefaults()
        if themes.isEmpty {
            // Default themes.
            insertTheme(name: "Transportation", emojis: ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎️", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍️", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"], numberOfPairs: 18, color: "red")
            insertTheme(name: "Sports", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳️", "🪁", "🏹", "🎣", "🥊"], numberOfPairs: 18, color: "blue")
            insertTheme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🦆", "🦅", "🦋"], numberOfPairs: 10, color: "mint")
            insertTheme(name: "Flags", emojis: ["🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇷", "🇦🇲", "🇦🇼", "🇦🇺", "🇦🇹", "🇦🇿", "🇧🇸", "🇧🇭", "🇧🇩", "🇧🇧", "🇧🇾", "🇧🇪", "🇧🇿", "🇺🇸"], numberOfPairs: 6, color: "indigo")
            insertTheme(name: "Objects", emojis: ["📷", "📞", "☎️", "📺", "📻", "🧭", "🎛️", "⏰", "⏳", "📡", "🔋", "💡", "🛢️", "💵", "🧰", "🔧", "🧲", "⛓️", "🔫", "🧨", "⚔️", "🛡️", "💊", "🧽"], numberOfPairs: 15, color: "orange")
            insertTheme(name: "Food", emojis: ["🍏", "🍎", "🍐", "🍊", "🍇", "🍉", "🍌", "🍋", "🍓", "🫐", "🍒", "🥥", "🍍", "🍑", "🥝", "🍅", "🥑", "🥒", "🥦", "🌽", "🫑", "🫒", "🍞", "🥨"], numberOfPairs: 10, color: "gray")
        }
    }
    
    func insertTheme(name: String, emojis: [String], numberOfPairs: Int, color: String) {
        themes.append(.init(name: name, emojis: emojis, numberOfPairs: numberOfPairs, color: color))
    }
    
    func insertTheme(_ theme: Theme<String>) {
        themes.append(theme)
    }
}
