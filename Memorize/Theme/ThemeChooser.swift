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
                        NavigationLink(destination: destination) {
                            chooseThemeRows(theme: theme)
                        }
                    }
                    .onDelete { indexSet in
                        store.themes.remove(atOffsets: indexSet)
                    }
                    .onMove { indexSet, newOffset in
                        store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                    }
                    // .gesture(editMode == .active ? tapToEditGesture : nil)
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
            store.insertTheme(name: "New", emojis: [], numberOfPairs: 0, color: "black")
            addingTheme = true
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .padding(.top)
    }
    
    // This gesture would allow the user to tap themes when in edit mode so they can also
    // edit themes that way, opposed to only being able to use the swipeAction button.
    // This isn't necessarily needed, and the app is complete without it, but would be
    // fun to implement.
    private var tapToEditGesture: some Gesture {
        TapGesture().onEnded {
            // TODO: -
            // How to set themeToEdit here? Can't pass it in via a function... Would have
            // to associate the navigation link selection with the underlying theme when
            // in edit mode.
            // themeToEdit = store.themes[someAssociatedIndex!]
        }
    }
    
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser()
            .environmentObject(ThemeStore())
    }
}
