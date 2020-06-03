//
//  GameStampViemModel.swift
//  dict
//
//  Created by Bartosz Zbislawski on 03/06/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import Foundation

class GameStampViewModel: ObservableObject {
    @Published private var model = GameStampModel()
    
    var correctStamp: GameStampModel.GameStamp {
        self.model.correctGameStamp
    }
    
    var wrongStamp: GameStampModel.GameStamp {
        self.model.wrongGameStamp
    }
}
