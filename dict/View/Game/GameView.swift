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
            ZStack {
                Rectangle()
                    .fill(Color.secondColor)
                    .overlay(GeometryReader { proxy in
                        Circle()
                            .fill(Color.white)
                            .frame(width: proxy.size.width + 1000, height: proxy.size.height + 1000)
                            .offset(x: (proxy.size.width + 1000) * 0.05, y: -(proxy.size.height + 1000) * 0.52)
                            .opacity(0.15)
                        
                    })
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.96)
                    .cornerRadius(25)
                    .shadow(color: .gray, radius: 12, x: 0, y: 4)
                
                
                
                VStack {
                    Image(systemName: "gamecontroller")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .font(.system(size: 56, weight: .bold))
                        .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.3)
                        .foregroundColor(.white)
                    
                    VStack {
                        HStack {
                            Text("Vocabulary")
                                .italic()
                                .padding(.leading, 30)
                                .foregroundColor(.white)
                                .font(.system(size: 36, weight: .thin))
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("Choose decks you want to play")
                                .italic()
                                .padding(.leading, 30)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(8)
                            .frame(height: 47)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.secondaryBackgroundColor, lineWidth: 1)
                        )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                            
                            .onTapGesture {
                                self.showSheet = true
                        }
                    }.padding(.bottom, geometry.size.height * 0.03)
                    
                    VStack {
                        HStack {
                            Text("Word Order")
                                .italic()
                                .padding(.leading, 30)
                                .foregroundColor(.white)
                                .font(.system(size: 36, weight: .thin))
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("Choose order of words displayed")
                                .italic()
                                .padding(.leading, 30)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(8)
                            .frame(height: 47)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.secondaryBackgroundColor, lineWidth: 1)
                        )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondaryBackgroundColor, lineWidth: 1)
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(height: 47)
                            .overlay(
                                Text("Start Game")
                                    .foregroundColor(Color.quaternaryBackgroundColor)
                                    .font(.system(size: 17, weight: .semibold))
                        )
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                    }
                }.frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.9)
            }
        }
        .sheet(isPresented: $showSheet) {
            GameSheetView().environmentObject(self.gameStatus).environmentObject(self.gamePlay)
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                GameView()
                
                Spacer()
                
                HStack {
                    Spacer()
                    Image(systemName: "book.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/5, height: 32)
                        .foregroundColor(.firstColor)
                    
                    
                    Image(systemName: "gamecontroller.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/5, height: 32)
                        
                        .foregroundColor(.firstColor)
                    
                    
                    Image(systemName: "gear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/5, height: 32)
                        .foregroundColor(.gray)
                    
                    
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height/10)
                .background(Color.white.shadow(radius: 2))
            }
            .edgesIgnoringSafeArea(.bottom)
            .accentColor(.firstColor)
        }
    }
}
