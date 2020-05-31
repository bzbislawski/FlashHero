//
//  FlashCardView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 22/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FlashCardView: View {
    @EnvironmentObject var gamePlay: GamePlay
    @ObservedObject var timeCounter = Timer()
    @State private var showAnswer = false
    @State private var showFrontText = true
    @State private var showReverseText = false
    @State private var goAway = GoAway.UNANSWERED
    @State private var currentPosition: CGSize = .zero
    var flashCard: FlashCard
    var animationDuration = 0.3
    
    private enum GoAway {
        static let CORRECT = 1
        static let WRONG = -1
        static let UNANSWERED = 0
    }
    
    var deckColor: DeckColor {
        deckColors.filter({return $0.name == self.flashCard.origin!.color}).first ?? deckColors.first!
    }
    
    func textView(text: String) -> some View {
        Text(text)
            .bold()
            .font(.title)
            .foregroundColor(Color.white)
            .frame(maxWidth: 280)
            .shadow(radius: 10)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [deckColor.colorOne, deckColor.colorTwo]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(10)
                .frame(width: 320, height: 200)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 4))
                .shadow(radius: 20, x: 0, y: self.showAnswer ? -20 : 20)
                .rotation3DEffect(.degrees(self.showAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
                .onTapGesture {
                    self.showAnswer.toggle()
            }
            
            self.textView(text: self.flashCard.wrappedWord)
                .opacity(self.showAnswer ? 0 : 1)
                .animation(Animation.linear(duration: self.animationDuration / 2))
                .rotation3DEffect(.degrees(self.showAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
                .onTapGesture {
                    self.showAnswer.toggle()
            }
            
            if self.showAnswer {
                self.textView(text: self.flashCard.wrappedTranslation)
                    .animation(.easeInOut(duration: 1.0))
                    .transition(.asymmetric(
                        insertion: AnyTransition.opacity.animation(Animation.easeInOut(duration: 0.5).delay(0.3)),
                        removal: AnyTransition.opacity.animation(Animation.easeInOut(duration: 0.1))))
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .offset(x: self.goAway != GoAway.UNANSWERED ? CGFloat(self.goAway) * UIScreen.main.bounds.width : self.currentPosition.width)
            
        .gesture(DragGesture()
        .onChanged { value in
            self.timeCounter.start()
            self.currentPosition = CGSize(width: value.translation.width, height: 0)
        }
        .onEnded { value in
            let interval = self.timeCounter.stop()
            let translation = abs(value.translation.width)
            let allowMove = translation > 180 ||
            (interval < 0.4 && translation > 50)
            
            if !allowMove {
                self.currentPosition = CGSize.zero
            } else {
                if self.currentPosition.width > 0 {
                    self.gamePlay.correctAnswers += 1
                    self.goAway = GoAway.CORRECT
                } else {
                    self.gamePlay.wrongAnswers += 1
                    self.goAway = GoAway.WRONG
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.gamePlay.flashCards.removeAll(where: { $0 == self.flashCard })
                }
            }
        })
            .onTapGesture {
                self.showAnswer.toggle()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration / 2) {
                    self.showFrontText.toggle()
                    self.showReverseText.toggle()
                }
        }
        
    }
}

struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let repository = FlashCardRepository(moc: context)
        let repository2 = DeckRepository(moc: context)
        let gameStatus = GameStatus(flashCardRepository: repository, deckRepository: repository2)
        
        let deck = Deck(context: context)
        deck.name = "Deck name"
        deck.color = "blue"
        
        let flashCard = FlashCard(context: context)
        flashCard.word = "Kitchen"
        flashCard.translation = "Kuchnia"
        deck.addToFlashCard(flashCard)
        try? context.save()
        
        return FlashCardView(flashCard: flashCard).environmentObject(gameStatus)
    }
}
