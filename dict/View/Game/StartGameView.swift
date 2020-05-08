//
//  StartGame.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

enum ActiveStartGameSheet {
    case vocabulary, cardsOrder
}

struct StartGameView: View {
    @EnvironmentObject var gameStatus: GameStatus
    @EnvironmentObject var gamePlay: GamePlay
    @State var showSheet: Bool = false
    @State var sheetType: ActiveStartGameSheet = .vocabulary
    @State private var cardsOrderOption = "Default"
    @State var showsAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            BackgroundView()
            
            VStack {
                HStack {
                    Text("New Game")
                        .foregroundColor(.fontColor)
                        .font(.system(size: 32, weight: .bold))
                    Spacer()
                }
                .frame(maxHeight: 44)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.top, 60)
                
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
                    if (self.gamePlay.selectedDecks.count == 0) {
                        self.showsAlert = true
                    } else {
                        self.gamePlay.start()
                    }
                }) {
                    ButtonView(text: "Start Game", backgroundColor: Color.darkBlue)
                }
                .alert(isPresented: self.$showsAlert) {
                    Alert(
                        title: Text("Oops!"),
                        message: Text("Select decks to start a game.")
                    )
                }
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
        return GeometryReader { geometry in
            VStack {
                StartGameView().environmentObject(gamePlay)
                TabView(geometry: geometry).environmentObject(env)
            }.edgesIgnoringSafeArea(.all)
        }
    }
}
