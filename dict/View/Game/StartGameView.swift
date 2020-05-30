//
//  StartGame.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

enum StartGameActiveAlert {
    case noSelectedDecksAlert, emptyDecksAlert
}

struct StartGameView: View {
    @EnvironmentObject var gameStatus: GameStatus
    @EnvironmentObject var gamePlay: GamePlay
    @State var showSheet: Bool = false
    @State var sheetType: ActiveSheet = .vocabulary
    @State private var cardsOrderOption = "Default"
    @State var showAlert = false
    @State var activeAlert = StartGameActiveAlert.noSelectedDecksAlert
    
    var body: some View {
        GeometryReader { geometry in            
            VStack {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color.lightBlue)
                        .frame(height: 156)
                    Image("game_start")
                }
                Spacer()
                
                VStack {
                    HStack {
                        Text("Vocabulary")
                            .italic()
                            .padding(.leading, 40)
                            .foregroundColor(Color.iconActive)
                            .font(.system(size: 36, weight: .bold))
                        Spacer()
                    }
                    
                    HStack {
                        Text("Choose decks you want to play")
                            .padding(.leading, 40)
                            .foregroundColor(Color.fontColor)
                        Spacer()
                    }
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(8)
                            .frame(height: 47)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.secondaryBackgroundColor, lineWidth: 1)
                        )
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            
                            .onTapGesture {
                                self.showSheet = true
                                self.sheetType = .vocabulary
                        }
                        Text("Selected decks: \(self.gamePlay.selectedDecks.count)")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color.quaternaryBackgroundColor)
                    }
                    
                    HStack {
                        Text("Word Order")
                            .italic()
                            .padding(.leading, 40)
                            .foregroundColor(Color.iconActive)
                            .font(.system(size: 36, weight: .bold))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("Choose order of words displayed")
                            .padding(.leading, 40)
                            .foregroundColor(Color.fontColor)
                        Spacer()
                    }
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(8)
                            .frame(height: 47)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.secondaryBackgroundColor, lineWidth: 1)
                        )
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            .onTapGesture {
                                self.showSheet = true
                                self.sheetType = .cardsOrder
                        }
                        Text("\(self.cardsOrderOption)")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color.quaternaryBackgroundColor)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    let nonEmptyDecks = self.gamePlay.selectedDecks.filter {
                        !$0.flashCardArray.isEmpty
                    }.count
                    
                    if (self.gamePlay.selectedDecks.count == 0) {
                        self.activeAlert = .noSelectedDecksAlert
                        self.showAlert = true
                    } else if nonEmptyDecks == 0 {
                        self.activeAlert = .emptyDecksAlert
                        self.showAlert = true
                    } else {
                        self.gamePlay.start()
                    }
                }) {
                    ButtonView(text: "Start Game", backgroundColor: Color.darkBlue)
                }
                .alert(isPresented: self.$showAlert) {
                    switch self.activeAlert {
                    case .noSelectedDecksAlert:
                        return Alert(
                            title: Text("Oops!"),
                            message: Text("Select decks to start a game.")
                        )
                    case .emptyDecksAlert:
                        return Alert(
                            title: Text("Oops!"),
                            message: Text("Selected decks don't have any flashcards.")
                        )
                    }
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $showSheet) {
            if self.sheetType == .vocabulary {
                SelectDecksView().environmentObject(self.gameStatus).environmentObject(self.gamePlay)
            } else if self.sheetType == .cardsOrder {
                CardsOrderView(cardsOrderOption: self.$cardsOrderOption).environmentObject(self.gamePlay)
            }
        }
    }
}

struct StartGame_Previews: PreviewProvider {
    static var previews: some View {
        let env = ViewRouter()
        let gamePlay = GamePlay()
        
        return VStack {
            StartGameView().environmentObject(gamePlay)
            Divider()
            TabView().environmentObject(env)
        }.edgesIgnoringSafeArea(.all)
    }
}
