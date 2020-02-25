//
//  Game.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameStatus: GameStatus
    @State var selectedDecks: [Deck] = []
    @State var showSheet: Bool = false
    
    var flashCards: Array<FlashCard> {
        return self.gameStatus.flashCards
    }
    
    var body: some View {
        NavigationView {
            Button(action: {self.showSheet = true}) {
                Text("Open sheet")
            }
                
                //            VStack {
                //                if flashCards.count == 0 {
                //                    Scoreboard()
                //                } else {
                //                    ScrollView(.vertical, showsIndicators: false) {
                //                        ForEach(flashCards, id: \.self) { flashCard in
                //                            FlashCardView(flashCard: flashCard)
                //                                .animation(.spring())
                //                                .padding(.top, 15)
                //                                .padding(.bottom, 15)
                //                                .padding(.leading, 300)
                //                                .padding(.trailing, 300)
                //                        }
                //                        Spacer()
                //                    }
                //                }
                //            }
                .navigationBarTitle("Swipe game")
                .sheet(isPresented: $showSheet) {
                    GameSheetView().environmentObject(self.gameStatus)
            }
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
