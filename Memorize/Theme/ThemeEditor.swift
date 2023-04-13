//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Joshua Galvan on 4/10/23.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme<String>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                nameSection
                addEmojisSection
                removeEmojisSection
                colorSection
                numberOfPairsSection
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    static var colors = ["blue","red","orange","purple","pink","green","brown","cyan","indigo","mint","white","black","gray"]
    var colorSection: some View {
        Section() {
            Picker("Color of cards", selection: $theme.color) {
                ForEach(ThemeEditor.colors, id: \.self) { color in
                    Text(color)
                }
            }
        }
    }
    
    @State private var numberOfPairs = ""
    var numberOfPairsSection: some View {
        Section() {
            Picker("Number of pairs", selection: $theme.numberOfPairs) {
                ForEach(0..<theme.emojis.count, id: \.self) {
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
            }
        }
    }
    
    var removeEmojisSection: some View {
        Section(header: Text("Remove Emojis")) {
            let emojis = theme.emojis.uniqued()
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 30))]) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                theme.emojis.removeAll { $0 == emoji }
                                if theme.numberOfPairs == theme.emojis.count {
                                    theme.numberOfPairs -= 1
                                }
                            }
                        }
                }
            }
            .font(.system(size: 30))
        }
    }
    
}

struct ThemeEditor_Previews: PreviewProvider {
    static var theme = Theme(name: "Food", emojis: ["🍏", "🍎", "🍐", "🍊", "🍇", "🍉", "🍌", "🍋", "🍓", "🫐", "🍒", "🥥", "🍍", "🍑", "🥝", "🍅", "🥑", "🥒", "🥦", "🌽", "🫑", "🫒", "🍞", "🥨"], numberOfPairs: 10, color: "gray")
    static var previews: some View {
        ThemeEditor(theme: .constant(theme))
    }
}
