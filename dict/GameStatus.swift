//
//  GameStatus.swift
//  dict
//
//  Created by Bartosz Zbislawski on 23/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import Foundation
import CoreData

class GameStatus: ObservableObject {
    @Published var correctAnswers: Int = 0
    @Published var wrongAnswers: Int = 0
    @Published var flashCards: Array<FlashCard> = []
    
    private var flashCardRepository: FlashCardRepository
    private var deckRepository: DeckRepository

    init(flashCardRepository: FlashCardRepository, deckRepository: DeckRepository) {
        self.flashCardRepository = flashCardRepository
        self.deckRepository = deckRepository
    }
    
    func save(word: String, translation: String) {
        flashCardRepository.save(word: word, translation: translation)
    }
    
    func delete(flashCard: FlashCard) {
        flashCardRepository.delete(flashCard: flashCard)
    }
    
    func save(name: String, color: String) {
        deckRepository.save(name: name, color: color)
    }
    
    func resetGame() {
        self.flashCards = flashCardRepository.getAll()
        self.correctAnswers = 0
        self.wrongAnswers = 0
    }
}
