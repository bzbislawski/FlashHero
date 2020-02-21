//
//  FlashCardView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 22/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FlashCardView: View {
    @EnvironmentObject var gameStatus: GameStatus
    @State private var showAnswer = false
    @State private var goAway = false
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    var flashCard: FlashCard
    
    var animation: Animation {
        Animation.interpolatingSpring(mass: 1, stiffness: 80, damping: 10, initialVelocity: 0)
    }
    
    var deckColor: DeckColor? {
        return deckColors.filter({return $0.name == self.gameStatus.deck?.color}).first
    }
    
    func textView(text: String, isAnswer: Bool) -> some View {
        Text(text)
            .bold()
            .font(.title)
            .foregroundColor(Color.white)
            .frame(maxWidth: 280)
            .shadow(radius: 10)
            .rotation3DEffect(Angle(degrees: isAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
            .offset(x: self.currentPosition.width, y: self.currentPosition.height)
            .rotation3DEffect(.degrees(self.showAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
            .onTapGesture {
                self.showAnswer.toggle()
        }
        .animation(self.animation)
        .gesture(DragGesture()
        .onChanged { value in
            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: self.showAnswer ? -1 * value.translation.height : value.translation.height + self.newPosition.height)
        }
        .onEnded { value in
            self.currentPosition = CGSize.zero
            self.newPosition = self.currentPosition
        })
    }
    
    var body: some View {
        ZStack {
            self.textView(text: self.flashCard.wrappedTranslation, isAnswer: true)
                .zIndex(self.showAnswer ? 1 : 0)
            
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [deckColor!.colorOne, deckColor!.colorTwo]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(10)
                .frame(width: 320, height: 200)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 4))
                .shadow(radius: 20, x: 0, y: self.showAnswer ? -20 : 20)
                .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                .rotation3DEffect(.degrees(self.showAnswer ? 180 : 0), axis: (x: 1, y: 0, z: 0))
                .onTapGesture {
                    self.showAnswer.toggle()
            }
            .animation(self.animation)
            .gesture(DragGesture()
            .onChanged { value in
                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: self.showAnswer ? -1 * value.translation.height : value.translation.height + self.newPosition.height)
                if self.currentPosition.width >= 180 || self.currentPosition.width <= -180 {
                    self.goAway = true
                    self.currentPosition.width *= 8
                }
            }
            .onEnded { value in
                if (!self.goAway) {
                    self.currentPosition = CGSize.zero
                    self.newPosition = self.currentPosition
                } else {
                    if self.currentPosition.width > 0 {
                        self.gameStatus.correctAnswers += 1
                    } else {
                        self.gameStatus.wrongAnswers += 1
                    }
                    self.gameStatus.flashCards.removeAll(where: { $0 == self.flashCard })
                }
            })
            
            self.textView(text: self.flashCard.wrappedWord, isAnswer: false)
                .zIndex(self.showAnswer ? -1 : 0)
        }
    }
}

struct FlashCardView_Previews: PreviewProvider {
    @Binding var param: Bool
    static var previews: some View {
        Game()
    }
}
