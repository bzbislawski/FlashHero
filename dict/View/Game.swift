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
    
    @FetchRequest(entity: FlashCard.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \FlashCard.word, ascending: false)
    ]) var flashCards: FetchedResults<FlashCard>
    
    func offset(index: Int) -> CGSize {
        return CGSize.init(width: 0, height: -(flashCards.count - index - self.gameStatus.answers) * 25)
    }
    
    func scaleEffect(index: Int) -> CGFloat {
        return CGFloat(1 - (0.05 * Double(flashCards.count - index - self.gameStatus.answers)))
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<flashCards.count) { index in
                FlashCardView(word: self.flashCards[index].word, translation: self.flashCards[index].translation)
                    .offset(self.offset(index: index))
                    .scaleEffect(self.scaleEffect(index: index))
                    .animation(.spring())
            }
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
