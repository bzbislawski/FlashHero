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
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color.secondColor)
                    .cornerRadius(25)
                    .padding(.all, 30)
                    .overlay (
                        Circle()
                            .fill(Color.backgroundColor)
                            .frame(width: 1300, height: 1300)
                            .offset(x: 80, y: -800)
                            .opacity(0.3)
                )
                
                VStack {
                    Image(systemName: "gamecontroller")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                        .foregroundColor(.white)
                        .padding(100)
                    
                    HStack {
                        Text("Vocabulary")
                            .italic()
                            .padding(.leading, 60)
                            .foregroundColor(.white)
                            .font(.system(size: 36, weight: .thin))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("Choose decks you want to play")
                            .italic()
                            .padding(.leading, 60)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(8)
                        .frame(height: 47)
                        .padding(.leading, 60)
                        .padding(.trailing, 60)

                        .onTapGesture {
                            self.showSheet = true
                    }
                    
                    Spacer()
                    
                    
                }
            }
            //.navigationBarTitle("Swipe game")
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
