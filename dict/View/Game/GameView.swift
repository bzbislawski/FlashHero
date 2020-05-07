//
//  GameView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 17/03/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gamePlay: GamePlay
    @State var selectedDecks: [Deck] = []
    @State var showSheet: Bool = false

    var flashCards: Array<FlashCard> {
        return self.gamePlay.flashCards
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                if self.gamePlay.isGameStarted {
                    if self.flashCards.count == 0 {
                        ScoreboardView()
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(self.flashCards, id: \.self) { flashCard in
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
                } else {
                    StartGameView()
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let env = ViewRouter()
        let gamePlay = GamePlay()
        return GameView().environmentObject(env).environmentObject(gamePlay)
    }
}
