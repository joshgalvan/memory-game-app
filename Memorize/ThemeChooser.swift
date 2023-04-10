//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Joshua Galvan on 4/10/23.
//

// This displays the ThemeChooser

import SwiftUI

struct ThemeChooser: View {
    @EnvironmentObject var store: ThemeStore
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))
                        .navigationBarTitleDisplayMode(.inline)) {
                        HStack {
                            Text(theme.name)
                            Text("-")
                            Text("\(theme.numberOfPairs)")
                            Spacer()
                            ForEach(theme.firstFourEmojis, id: \.self) { emoji in
                                Text(emoji)
                            }
                        }
                        .foregroundColor(theme.UIColor)
                    }
                }
            }
            .navigationTitle("Choose theme")
        }
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser()
            .environmentObject(ThemeStore())
    }
}
