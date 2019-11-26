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
    @EnvironmentObject var gameStatus: GameStatus
    
    var flashCards: Array<FlashCard> {
        return self.gameStatus.fetchAllFlashCards()
    }
    
    var answersCount: Int {
        return self.gameStatus.answers
    }
    
    func offset(index: Int) -> CGSize {
        return CGSize.init(width: 0, height: -(flashCards.count - index - answersCount) * 25)
    }
    
    func scaleEffect(index: Int) -> CGFloat {
        return CGFloat(1 - (0.05 * Double(flashCards.count - index - answersCount)))
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                ForEach(0..<flashCards.count) { index in
                    FlashCardView(word: self.flashCards[index].word, translation: self.flashCards[index].translation)
                        .offset(self.offset(index: index))
                        .scaleEffect(self.scaleEffect(index: index))
                        .animation(.spring())
                }
            }.navigationBarTitle("Swipe game")
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
