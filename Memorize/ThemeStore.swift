//
//  ThemeStore.swift
//  Memorize
//
//  Created by Joshua Galvan on 4/9/23.
//

import SwiftUI

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
}
