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
    
    var answersCount: Int {
        return self.gameStatus.answers
    }
    
    var flashCards: Array<FlashCard> {
        return self.gameStatus.flashCards
    }
    
    var body: some View {
        VStack {
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
        }.navigationBarTitle("Swipe game")
        
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
