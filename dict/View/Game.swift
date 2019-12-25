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
        return self.gameStatus.flashCards
    }
    
    var body: some View {
        VStack {
            if self.gameStatus.flashCards.count == 0 {
                EndOfGame()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(flashCards, id: \.self) { flashCard in
                        FlashCardView(flashCard: flashCard)
                            .animation(.spring())
                            .padding(.top, 15)
                            .padding(.bottom, 15)
                            .padding(.leading, 300)
                            .padding(.trailing, 300)
                    }
                    Spacer()
                }
            }
        }.navigationBarTitle("Swipe game")
        
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
