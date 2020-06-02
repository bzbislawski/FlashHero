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
    
    var body: some View {
        Group {
            if self.gamePlay.isGameStarted {
                if self.gamePlay.flashCards.count == 0 {
                    ScoreboardView()
                } else {
                    GamePlayView()
                }
            } else {
                Group {
                    StartGameView()
                    Divider()
                    TabView()
                        .frame(height: UIScreen.main.bounds.height * 0.1)
                        .background(Color.backgroundColor)
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
