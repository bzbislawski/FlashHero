//
//  Homepage.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct Homepage: View {
    @EnvironmentObject var gameStatus: GameStatus
    
    var body: some View {
        TabView {
            Game()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Game")
                }
            .onAppear{ self.gameStatus.resetGame()}
            Dictionary()
                .tabItem {
                    Image(systemName: "book")
                    Text("Dictionary")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("About")
                }
        }
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
