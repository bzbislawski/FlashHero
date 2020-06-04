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
    @ObservedObject var gameStampViewModel = GameStampViewModel()
    @State private var showAnswer = false
    @State private var showFrontText = true
    @State private var showReverseText = false
    @State private var goAway = GoAway.UNANSWERED
    @State private var currentPosition: CGSize = .zero
    @State private var offsetPercentage: Double = 0.0
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
            .frame(minWidth: 300, minHeight: 200)
            .shadow(radius: 10)
            .padding(.leading, 60)
            .padding(.trailing, 60)
            .padding(.top, 10)
            .padding(.bottom, 10)
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [deckColor.colorOne, deckColor.colorTwo]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(10)
                    .frame(minWidth: 320, minHeight: 200)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 20, x: 0, y: self.showAnswer ? -20 : 20)
                    .rotation3DEffect(.degrees(self.showAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
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
            .rotationEffect(.degrees(self.offsetPercentage / 100) * 5)
            .gesture(DragGesture()
            .onChanged { value in
                self.timeCounter.start()
                self.currentPosition = CGSize(width: value.translation.width, height: 0)
                self.offsetPercentage = Double(value.translation.width) / 180 * 100
            }
            .onEnded { value in
                let interval = self.timeCounter.stop()
                let translation = abs(value.translation.width)
                let allowMove = translation > 180 ||
                    (interval < 0.4 && translation > 50)
                
                if !allowMove {
                    self.currentPosition = CGSize.zero
                    self.offsetPercentage = 0
                } else {
                    if self.currentPosition.width > 0 {
                        self.gamePlay.correctAnswers += 1
                        self.goAway = GoAway.CORRECT
                        self.offsetPercentage = 100
                    } else {
                        self.gamePlay.wrongAnswers += 1
                        self.goAway = GoAway.WRONG
                        self.offsetPercentage = -100
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.gamePlay.flashCards.removeAll(where: { $0 == self.flashCard })
                        self.offsetPercentage = 0
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
            if (self.offsetPercentage) > 10 {
                GameStampView(gameStamp: self.gameStampViewModel.correctStamp, offsetPercentage: self.offsetPercentage)
            }
            if (self.offsetPercentage) < -10 {
                GameStampView(gameStamp: self.gameStampViewModel.wrongStamp, offsetPercentage: self.offsetPercentage)
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
