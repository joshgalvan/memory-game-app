//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Joshua Galvan on 3/15/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
