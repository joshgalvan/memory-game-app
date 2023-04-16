//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Joshua Galvan on 4/10/23.
//

import SwiftUI

struct ThemeChooser: View {
    @EnvironmentObject var store: ThemeStore
    @State private var addingTheme = false
    @State private var themeToEdit: Theme<String>?
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(store.themes) { theme in
                        let destination = EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))
                            .navigationBarTitleDisplayMode(.inline)
                        ZStack {
                            NavigationLink(destination: destination) {
                                chooseThemeRows(theme: theme)
                            }
                            
                            // Allow the NavigationLink section to be tappable while in
                            // edit mode.
                            Button {
                                if editMode == .active {
                                    themeToEdit = theme
                                }
                            } label: {
                                Color.clear
                            }
                        }
                    }
                    .onDelete { indexSet in
                        store.themes.remove(atOffsets: indexSet)
                    }
                    .onMove { indexSet, newOffset in
                        store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                    }
                }
                .navigationTitle("Choose theme")
                .toolbar {
                    ToolbarItem { EditButton() }
                }
                .environment(\.editMode, $editMode)
            }
            newThemeButton
        }
        .sheet(isPresented: $addingTheme) {
            ThemeEditor(theme: $store.themes.last!)
        }
        .sheet(item: $themeToEdit) { theme in
            ThemeEditor(theme: $store.themes[theme])
        }
    }
    
    private func chooseThemeRows(theme: Theme<String>) -> some View {
        HStack {
            // Could be stylized better.
            Text(theme.name)
            Text("-")
            Text("\(theme.numberOfPairs)")
            Spacer()
            ForEach(theme.emojis.prefix(2), id: \.self) { emoji in
                Text(emoji)
            }
        }
        .foregroundColor(theme.UIColor)
        .swipeActions {
            Button {
                themeToEdit = theme
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.yellow)
            
            if editMode == .active {
                Button(role: .destructive) {
                    store.removeTheme(theme)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
        
    private var newThemeButton: some View {
        Button("New Theme") {
            store.insertTheme(name: "New", emojis: ["😀","🤣"], numberOfPairs: 2, color: "gray")
            addingTheme = true
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .padding(.bottom)
        .padding(.top, 8)
    }
        
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser()
            .environmentObject(ThemeStore())
    }
}
