//
//  ThemeStore.swift
//  Memorize
//
//  Created by Joshua Galvan on 4/9/23.
//

import SwiftUI

// This doesn't really need to be generic, but it's fine for now.
struct Theme<CardContent>: Codable, Equatable, Identifiable, Hashable where CardContent: Codable & Equatable & Hashable {
    var name: String
    var emojis: [CardContent]
    var numberOfPairs: Int
    var color: String
    var id = UUID()
    
    init(name: String, emojis: [CardContent], numberOfPairs: Int, color: String) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairs = numberOfPairs
        self.color = color
    }
    
    var UIColor: Color {
        switch self.color.localizedLowercase {
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
        case "black": return .black
        default: return .gray
        }
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
            insertTheme(name: "Food", emojis: ["🍏", "🍎", "🍐", "🍊", "🍇", "🍉", "🍌", "🍋", "🍓", "🫐", "🍒", "🥥", "🍍", "🍑", "🥝", "🍅", "🥑", "🥒", "🥦", "🌽", "🫑", "🫒", "🍞", "🥨"], numberOfPairs: 10, color: "pink")
        }
    }
    
    func printAllIDs() {
        for (i, theme) in themes.enumerated() {
            print("\(theme.id): \(i)")
        }
    }
    
    // MARK: Intents
    
    func insertTheme(name: String, emojis: [String], numberOfPairs: Int, color: String) {
        themes.append(.init(name: name, emojis: emojis, numberOfPairs: numberOfPairs, color: color))
    }
    
    func insertTheme(_ theme: Theme<String>) {
        themes.append(theme)
    }
    
    func removeTheme(_ theme: Theme<String>) {
        themes.remove(theme)
    }
    
}
