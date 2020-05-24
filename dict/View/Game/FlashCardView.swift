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
    @State private var showAnswer = false
    @State private var goAway = false
    @State private var currentPosition: CGSize = .zero
    var flashCard: FlashCard
    
    var animation: Animation {
        Animation.interpolatingSpring(mass: 1, stiffness: 80, damping: 10, initialVelocity: 0)
    }
    
    var deckColor: DeckColor {
        deckColors.filter({return $0.name == self.flashCard.origin!.color}).first ?? deckColors.first!
    }
    
    func textView(text: String, isAnswer: Bool) -> some View {
        Text(text)
            .bold()
            .font(.title)
            .foregroundColor(Color.white)
            .frame(maxWidth: 280)
            .shadow(radius: 10)
            .rotation3DEffect(Angle(degrees: isAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
            .rotation3DEffect(.degrees(self.showAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
    }
    
    var body: some View {
        ZStack {
            self.textView(text: self.flashCard.wrappedTranslation, isAnswer: true)
                .zIndex(self.showAnswer ? 1 : 0)
            
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [deckColor.colorOne, deckColor.colorTwo]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(10)
                .frame(width: 320, height: 200)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 4))
                .shadow(radius: 20, x: 0, y: self.showAnswer ? -20 : 20)
                .rotation3DEffect(.degrees(self.showAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
            
            self.textView(text: self.flashCard.wrappedWord, isAnswer: false)
                .zIndex(self.showAnswer ? -1 : 0)
        }
        .frame(width: UIScreen.main.bounds.width)
        .offset(x: self.goAway ? UIScreen.main.bounds.width : self.currentPosition.width)
        .animation(self.animation)
        .gesture(DragGesture()
        .onChanged { value in
            self.currentPosition = CGSize(width: value.translation.width, height: 0)
        }
        .onEnded { value in
            if value.translation.width < 180 && value.translation.width > -180 {
                self.currentPosition = CGSize.zero
            } else {
                self.goAway.toggle()
                if self.currentPosition.width > 0 {
                    self.gamePlay.correctAnswers += 1
                } else {
                    self.gamePlay.wrongAnswers += 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.gamePlay.flashCards.removeAll(where: { $0 == self.flashCard })
                }
            }
        })
            .onTapGesture {
                self.showAnswer.toggle()
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
