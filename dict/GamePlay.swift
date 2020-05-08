//
//  Game.swift
//  dict
//
//  Created by Bartosz Zbislawski on 25/02/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import Foundation
import SwiftUI

struct ScoreboardData {
    let text: String
    let color: Color
    let image: String
    let sentence: String
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
    
    private enum Medal {
        static let FIRST_PRIZE = 1
        static let SECOND_PRIZE = 2
        static let THIRD_PRIZE = 3
    }
    
    let scoreBoardData = [
        Medal.FIRST_PRIZE: ScoreboardData(text: "Well done 🥳", color: Color.rgb(r: 39, g: 130, b: 20), image: "scoreboard_first", sentence: "You’ve done very well. You\n are a total learning beast.\nThe score is amazing!"),
        Medal.SECOND_PRIZE: ScoreboardData(text: "Good job! ☺️", color: Color.rgb(r: 229, g: 112, b: 34), image: "scoreboard_second", sentence: "Great effort! Keep\npracticing! Your score is\npretty good as well."),
        Medal.THIRD_PRIZE: ScoreboardData(text: "Whoops! 🤯", color: Color.rgb(r: 214, g: 28, b: 28), image: "scoreboard_third", sentence: "You need a little bit more\npractice. Keep it up and you\nwill get better scores!"),
    ]
    
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
    
    func getScoreboardData() -> ScoreboardData {
        let score = Float(self.correctAnswers) / Float(self.getTotalScore())
        
        if score >= 0.9 {
            return self.scoreBoardData[Medal.FIRST_PRIZE]!
        } else if score >= 0.6 {
            return self.scoreBoardData[Medal.SECOND_PRIZE]!
        } else {
            return self.scoreBoardData[Medal.THIRD_PRIZE]!
        }
    }
    
    func getTotalScore() -> Int {
        return self.correctAnswers + self.wrongAnswers
    }
}
