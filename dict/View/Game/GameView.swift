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
        return GeometryReader { geometry in
            VStack {
                if self.gamePlay.isGameStarted {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
