//
//  Game.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct Game: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var showAnswer = false
    @EnvironmentObject var gameStatus: GameStatus    
    
    var body: some View {
        ZStack {
            FlashCardView(showAnswer: self.$showAnswer, word: "Mietek", translation: "Piesel").offset(y: -125).scaleEffect(0.75 + CGFloat(Double(self.gameStatus.answers) * 0.05)).animation(.spring())
            FlashCardView(showAnswer: self.$showAnswer, word: "Mietek", translation: "Piesel").offset(y: -100).scaleEffect(0.80 + CGFloat(Double(self.gameStatus.answers) * 0.05)).animation(.spring())
            FlashCardView(showAnswer: self.$showAnswer, word: "Mietek", translation: "Piesel").offset(y: -75).scaleEffect(0.85 + CGFloat(Double(self.gameStatus.answers) * 0.05)).animation(.spring())
            FlashCardView(showAnswer: self.$showAnswer, word: "Mietek", translation: "Piesel").offset(y: -50).scaleEffect(0.90 + CGFloat(Double(self.gameStatus.answers) * 0.05)).animation(.spring())
            FlashCardView(showAnswer: self.$showAnswer, word: "Mietek", translation: "Piesel").offset(y: -25).scaleEffect(0.95 + CGFloat(Double(self.gameStatus.answers) * 0.05)).animation(.spring())
            FlashCardView(showAnswer: self.$showAnswer, word: "Mietek", translation: "Piesel")
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
