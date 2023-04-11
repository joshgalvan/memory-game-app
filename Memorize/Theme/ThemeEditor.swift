//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Joshua Galvan on 4/10/23.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme<String>
    
    var body: some View {
        Form {
            nameSection
            colorSection
            addEmojisSection
            removeEmojisSection
            numberOfPairsSection
        }
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    var colorSection: some View {
        Section(header: Text("Color")) {
            TextField("Color", text: $theme.color)
        }
    }
    
    @State private var numberOfPairs = ""
    var numberOfPairsSection: some View {
        Section(header: Text("Number of pairs")) {
            Picker("", selection: $theme.numberOfPairs) {
                ForEach(0..<(theme.emojis.count / 2) + 1, id: \.self) {
                    Text(String($0))
                }
            }
        }
    }
    
    @State private var emojisToAdd = ""
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                }
        }
    }
    
    func addEmojis(_ emojis: String) {
        withAnimation {
            // Need to ensure user can only add emojis.
            if let last = emojis.last, !theme.emojis.contains(String(last)), last.isEmoji {
                theme.emojis.append(String(emojis.last!))
                print("inside \(theme.emojis)")
            }
        }
    }
    
    var removeEmojisSection: some View {
        Section(header: Text("Remove Emojis")) {
            let emojis = theme.emojis.uniqued()
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 30))]) {
                ForEach(theme.emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                theme.emojis.removeAll { $0 == emoji }
                            }
                        }
                }
            }
            .font(.system(size: 30))
        }
    }
    
}

//struct ThemeEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeEditor()
//    }
//}
