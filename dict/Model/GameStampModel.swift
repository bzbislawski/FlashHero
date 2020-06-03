//
//  GameStampModel.swift
//  dict
//
//  Created by Bartosz Zbislawski on 03/06/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import Foundation
import SwiftUI

struct GameStampModel {
    var correctGameStamp: GameStamp
    var wrongGameStamp: GameStamp
    
    init() {
        correctGameStamp = GameStamp(text: "CORRECT", color: Color.green, offset: -100, degrees: -30)
        wrongGameStamp = GameStamp(text: "WRONG", color: Color.red, offset: 100, degrees: 30)
    }
    
    struct GameStamp {
        var text: String
        var color: Color
        var offset: Int
        var degrees: Double
    }
}
