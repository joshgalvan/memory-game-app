//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Joshua Galvan on 4/10/23.
//

// This displays the game.

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            header
            gameBody
            restartGameButton
        }
        .padding(.horizontal)
    }
    
    var header: some View {
        HStack {
            Text(game.themeName)
            Spacer()
            HStack {
                Text("Score:")
                Text(String(game.score)).foregroundColor(.yellow)
            }
        }
        .font(.title)
    }
        
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: DrawingConstant.aspectRatio) { card in
            if card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card)
                    .padding(4)
                    .transition(AnyTransition.scale.animation(.easeInOut))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
        .cornerRadius(DrawingConstant.cornerRadius)
        .foregroundColor(game.color)
    }
    
    var restartGameButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.20)) {
                game.restart()
            }
        } label: {
            Text("Restart")
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .padding(.bottom)
        .padding(.top, 8)
    }
    
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text(card.content)
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(Animation.easeInOut(duration: 1), value: card.isMatched)
                    .font(Font.system(size: Constant.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (Constant.fontSize / Constant.fontScale)
    }
    
    private struct Constant {
        static let cornerRadius: CGFloat = DrawingConstant.cornerRadius
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let opacity: CGFloat = 0.5
        static let fontSize: CGFloat = 32
    }
}

fileprivate struct DrawingConstant {
    static let cornerRadius: CGFloat = 10
    static let aspectRatio: CGFloat = 2/3
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let theme = Theme(name: "Test", emojis: ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎️", "🚑", "🚓", "🚒", "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍️", "🛺", "🚠", "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"], numberOfPairs: 18, color: "red")
        let game = EmojiMemoryGame(theme: theme)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
