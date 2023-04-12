//
//  EmojiMemoryameView.swift
//  Memorize
//  View
//
//  Created by Joshua Galvan on 2/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ThemeChooser()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
            .preferredColorScheme(.light)
            .environmentObject(ThemeStore())
    }
}

// TODO: Make game show correct theme color
// TODO: Picker for color would be good
