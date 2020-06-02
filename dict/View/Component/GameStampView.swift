//
//  GameStampView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 02/06/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct GameStampView: View {
    var offsetPercentage: Double
    
    var body: some View {
        Text(self.offsetPercentage > 0 ? "CORRECT" : "WRONG")
            .font(.system(size: 38, weight: .semibold))
            .frame(maxWidth: 200, maxHeight: 100)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(style: StrokeStyle(lineWidth: 5, dash: [10, 5]))
            )
            .foregroundColor(offsetPercentage > 0 ? Color.green : Color.red)
            .offset(x: offsetPercentage > 0 ? -100 : 100, y: -100)
            .rotationEffect(offsetPercentage > 0 ? .degrees(-30) : .degrees(30))
            .opacity(abs(offsetPercentage / 100))
    }
}

struct GameStampView_Previews: PreviewProvider {
    static var previews: some View {
        GameStampView(offsetPercentage: 50.0)
    }
}
