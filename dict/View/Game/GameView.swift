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
    @EnvironmentObject var gamePlay: GamePlay
    @State var showSheet: Bool = false
    
    var flashCards: Array<FlashCard> {
        return self.gameStatus.flashCards
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Swipe Game")
                    .font(.system(size: 44, weight: .thin))
                
                ZStack {
                    Rectangle()
                        .fill(Color.secondColor)
                        .overlay(GeometryReader { proxy in
                            Circle()
                                .fill(Color.white)
                                .frame(width: proxy.size.width + 1000, height: proxy.size.height + 1000)
                                .offset(x: (proxy.size.width + 1000) * 0.05, y: -(proxy.size.height + 1000) * 0.50)
                                .opacity(0.15)
                            
                        })
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8)
                        .cornerRadius(5).shadow(radius:5)
                    
                    
                    
                    //                    VStack {
                    //                        Image(systemName: "gamecontroller")
                    //                            .resizable()
                    //                            .aspectRatio(contentMode: .fit)
                    //                            .font(.system(size: 56, weight: .bold))
                    //                            .frame(width: 100, height: 100)
                    //                            .foregroundColor(.white)
                    //                            .padding(.top, 60)
                    //
                    //                        HStack {
                    //                            Text("Vocabulary")
                    //                                .italic()
                    //                                .padding(.leading, 30)
                    //                                .foregroundColor(.white)
                    //                                .font(.system(size: 36, weight: .thin))
                    //
                    //                            Spacer()
                    //                        }
                    //
                    //                        HStack {
                    //                            Text("Choose decks you want to play")
                    //                                .italic()
                    //                                .padding(.leading, 30)
                    //                                .foregroundColor(.white)
                    //                            Spacer()
                    //                        }
                    //                        Rectangle()
                    //                            .fill(Color.white)
                    //                            .cornerRadius(8)
                    //                            .frame(height: 47)
                    //                            .overlay(
                    //                                RoundedRectangle(cornerRadius: 8)
                    //                                    .stroke(Color.secondaryBackgroundColor, lineWidth: 1)
                    //                        )
                    //                            .padding(.leading, 30)
                    //                            .padding(.trailing, 30)
                    //
                    //                            .onTapGesture {
                    //                                self.showSheet = true
                    //                        }
                    //
                    //                        HStack {
                    //                            Text("Word Order")
                    //                                .italic()
                    //                                .padding(.leading, 30)
                    //                                .foregroundColor(.white)
                    //                                .font(.system(size: 36, weight: .thin))
                    //
                    //                            Spacer()
                    //                        }
                    //
                    //                        HStack {
                    //                            Text("Choose order of words displayed")
                    //                                .italic()
                    //                                .padding(.leading, 30)
                    //                                .foregroundColor(.white)
                    //                            Spacer()
                    //                        }
                    //                        Rectangle()
                    //                            .fill(Color.white)
                    //                            .cornerRadius(8)
                    //                            .frame(height: 47)
                    //                            .overlay(
                    //                                RoundedRectangle(cornerRadius: 8)
                    //                                    .stroke(Color.secondaryBackgroundColor, lineWidth: 1)
                    //                        )
                    //                            .padding(.leading, 30)
                    //                            .padding(.trailing, 30)
                    //
                    //                        Spacer()
                    //
                    //                        Button(action: {}) {
                    //                            RoundedRectangle(cornerRadius: 8)
                    //                                .stroke(Color.secondaryBackgroundColor, lineWidth: 1)
                    //                                .background(Color.white)
                    //                                .cornerRadius(8)
                    //                                .frame(height: 47)
                    //                                .overlay(
                    //                                    Text("Start Game")
                    //                                        .foregroundColor(Color.quaternaryBackgroundColor)
                    //                                        .font(.system(size: 17, weight: .semibold))
                    //                            )
                    //                                .padding(.leading, 60)
                    //                                .padding(.trailing, 60)
                    //                                .padding(.top, 80)
                    //                                .padding(.bottom, 80)
                    //                        }
                    //                    }
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            GameSheetView().environmentObject(self.gameStatus).environmentObject(self.gamePlay)
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
