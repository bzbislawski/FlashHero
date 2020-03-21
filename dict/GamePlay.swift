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
    @Published var selectedCardsOrder: String = "Default"
    @Published var isGameStarted: Bool = false
    @Published var flashCards: [FlashCard] = []
    
    @Published var correctAnswers: Int = 0
    @Published var wrongAnswers: Int = 0
    
    var cardsOrder: Array<String> {
        return ["Default", "Alphabetical", "Random"]
    }
    
    func start() -> Void {
        self.isGameStarted = true
        
        var flashCards: [FlashCard] = []
        selectedDecks.forEach {
            flashCards += $0.flashCardArray
        }
        self.flashCards = flashCards
    }
    
    func stop() {
        self.isGameStarted = false
        self.correctAnswers = 0
        self.wrongAnswers = 0
    }
    
    func reset() {
        self.selectedDecks = []
        self.selectedCardsOrder = "Default"
    }
}
