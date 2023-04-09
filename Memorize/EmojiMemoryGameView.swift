//
//  EmojiMemoryameView.swift
//  Memorize
//  View
//
//  Created by Joshua Galvan on 2/27/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            header
            gameBody
            newGameButton
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
    
    var newGameButton: some View {
        Button {
            withAnimation {
                game.updateRandomTheme()
            }
        } label: {
            Text("New Game")
        }
        .frame(height: 20)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}

/*
 
Some Notes: Lecture 6: Learn More About Protocols
 
 A protocol is a sort of "stripped-down" struct/class that defines things other
 structs/classes can implemenet to become compliant with it.
 
 Protocols have inheritance, and multiple inheritance.
 
 Extending protocols allow you to implement things for a protocol.
 This is how a lot of the default implementation is added in SwiftUI
 
 
 Some Notes: Lecture 7: Animation
 
 Animation with ViewModifiers
 
 ViewModifier protocol only has one function in it.
 This function's only job is to create a new View based on the thing passed to it.
 
 protocol ViewModifier {
    typealias Content // the type of the View passed to body(content:)
    func body(content: Content) -> some View {
        // return some View that almost certainly contains the View content
 }
 
 Create our own ViewModifiers
 
 Animation struct:
    duration
    delay
    repeat
    curve:
        .linear
        .easeInOut
        .spring
 
 There's automatic/implicit animation. That's using .animation(Animation) to the view you want to auto-animate. It will animate all of the ViewModifiers that precede the animation modifier.
 Automatic animation will propogate the .animation modifier to all of the Views contained in a container if applied to a container.
 
 Automatic animation is not the primary way you will be doing animation, that will be through Explicit Animation.
 
 Automatic/implicit animation is deprecated. Do not use it.
 
 Explicit Animation:
    Create an animation transaction.
    All eligible changes made as a result of executing a block of code will be animated together during this transaction.
    withAnimation(.linear(duration: 2)) {
        // do something that will cause viewModifer/Shape arguments to change somewhere
    Explicit animations are almost always wrapped around calls to ViewModel Intent functions. But they are also wrapped around things that only change the UI like "entering editing mode." It's fairly rare for code that handles a user gesture to not be wrapped in a withAnimation.
 
    Explicit animations doe not override an implicit animation. The .animation animations are assumed to be independent of other animations. They're not going to be affected by an explicit animation.
 
 Transitions:
    Only works for Views that are INSIDE CONTAINERS THAT ARE ALREADY ON SCREEN.
    This specifies how to animate the arrival/departure of Views
    This is using .transition() modifiers, and there are pre-built canned transitions that we mainly use. You can build your own transitions though.
    .transition() does not get propogated to a container's content Views.
    Group and ForEach do distribute .transition() to their content Views, however
    An opacity transition is the default transition. Fade in and out.
 
    You can set animation details for a transition (curve/duration/etc.)
    .transition(AnyTransition.opacity.animation(.linear(duration: 20)))
 
    Sometimes you want a view to move from one place on screen to another, usually within the same container view, like a LazyVGrid.
    Like for example the cards in our LazyVGrid. Maybe the contents of the ForEach change or get mixed and you want to animate things moving around. This is normal and "moving" like this is just animating the .position ViewModifier's arguments. (.position is what HStack, LazyVGrid, etc., use to position the Views inside them.) This kind of thing happens automatically when you explicitly animate.
 
    MatchedGeometryEffect:
    What if the View is "moving" from one container to a different container?
    You would need a view in the "source" position and then another view in the "destination" position. Then you must "match" their geometries up as one leaves the UI and the other arrives. So this is similar to .transition in that it is animating Views' coming and going in the UI. It's just that it's particular to the case where a pair of Views' arrivals/departures are synced.
 
 
 .onAppear:
    Kick off an animation as soon as a View's Container arrives on screen.
    .onAppear exectues a closure any time a View appears on screen (there's also .onDisappear.
    Use .onAppear { } on your CONTAINER view to cause a change (usually in Model/ViewModel) that results in the appearance/animation of the View you want to be animated.
    You'd need to use withAnimation inside .onAppear { }.
    For example, can use .onAppear to start the animation for the pie on our card once it appears.
*/

