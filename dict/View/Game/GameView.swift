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
        VStack {
            if self.gamePlay.isGameStarted {
                if self.gamePlay.flashCards.count == 0 {
                    ZStack {
                        BackgroundView()
                        ScoreboardView()
                    }.edgesIgnoringSafeArea(.all)
                } else {
                    ZStack {
                        BackgroundView()
                        GamePlayView()
                    }
                }
            } else {
                ZStack {
                    BackgroundView()
                    VStack {
                        StartGameView()
                        Divider()
                        TabView()
                            .frame(height: UIScreen.main.bounds.height * 0.1)
                            .background(Color.backgroundColor)
                    }
                }.edgesIgnoringSafeArea(.all)
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
