//
//  GameStampView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 02/06/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct GameStampView: View {
    var gameStamp: GameStampModel.GameStamp
    var offsetPercentage: Double
    
    var body: some View {
        Text(self.gameStamp.text)
            .font(.system(size: 38, weight: .semibold))
            .frame(maxWidth: 200, maxHeight: 100)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(style: StrokeStyle(lineWidth: 5, dash: [10, 5]))
            )
            .foregroundColor(self.gameStamp.color)
            .rotationEffect(.degrees(self.gameStamp.degrees))
            .offset(x: CGFloat(self.gameStamp.offset), y: -20)
            .opacity(abs(self.offsetPercentage / 100))
    }
}

struct GameStampView_Previews: PreviewProvider {
    static var previews: some View {
        GameStampView(gameStamp: GameStampModel.GameStamp(text: "CORRECT", color: Color.green, offset: -100, degrees: -30), offsetPercentage: 50.0)
    }
}
