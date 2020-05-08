//
//  Game.swift
//  dict
//
//  Created by Bartosz Zbislawski on 25/02/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import Foundation

enum Medal {
    static let FIRSRT_PRIZE = 1
    static let SECOND_PRIZE = 2
    static let THIRD_PRIZE = 3
}

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
        
        switch self.selectedCardsOrder {
        case "Alphabetical":
            self.flashCards = flashCards.sorted {$0.wrappedWord < $1.wrappedWord }
        case "Random":
            self.flashCards = flashCards.shuffled()
        default:
            self.flashCards = flashCards
        }
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
    
    func getMedal() -> Int {
        let score = Float(self.correctAnswers) / Float(self.getTotalScore())
        
        if score >= 0.9 {
            return Medal.FIRSRT_PRIZE
        } else if score >= 0.6 {
            return Medal.SECOND_PRIZE
        } else {
            return Medal.THIRD_PRIZE
        }
    }
    
    func getTotalScore() -> Int {
        return self.correctAnswers + self.wrongAnswers
    }
}
