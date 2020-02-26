//
//  Game.swift
//  dict
//
//  Created by Bartosz Zbislawski on 25/02/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import Foundation

class GamePlay: ObservableObject {
    @Published var selectedDecks: [Deck] = []
}
