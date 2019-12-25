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
    @Published var answers: Int = 0
    @Published var flashCards: Array<FlashCard> = []
    
    private var flashCardRepository: FlashCardRepository

    init(flashCardRepository: FlashCardRepository) {
        self.flashCardRepository = flashCardRepository
    }
    
    func save(word: String, translation: String) {
        flashCardRepository.save(word: word, translation: translation)
    }
    
    func delete(flashCard: FlashCard) {
        flashCardRepository.delete(flashCard: flashCard)
    }
    
    func getAll() -> Array<FlashCard> {
        return flashCardRepository.getAll()
    }
}
