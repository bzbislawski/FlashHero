//
//  EndOfGame.swift
//  dict
//
//  Created by Bartosz Zbislawski on 25/12/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct EndOfGame: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var gameStatus: GameStatus
    
    var body: some View {
        let totalScore = Float(self.gameStatus.correctAnswers) + Float(self.gameStatus.wrongAnswers)
        let score = Float(self.gameStatus.correctAnswers) / totalScore
        return VStack {
            if (score > 0.60) {
                Text("Congratulations" + String(score))
            } else {
                Text("You could have done better" + String(score))
            }
        
        Image(systemName: "arrow.clockwise.circle")
        }
    }
}

struct EndOfGame_Previews: PreviewProvider {
    static var previews: some View {
        EndOfGame()
    }
}
