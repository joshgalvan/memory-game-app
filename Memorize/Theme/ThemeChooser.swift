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
    @State private var addingTheme = false
    
    var body: some View {
        NavigationStack {
            VStack {
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
            Button("Add Theme") {
                addingTheme = true
                store.insertTheme(name: "New", emojis: [], numberOfPairs: 0, color: "black")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.top)
        }
        .sheet(isPresented: $addingTheme) {
            ThemeEditor(theme: $store.themes.last!)
        }
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser()
            .environmentObject(ThemeStore())
    }
}
