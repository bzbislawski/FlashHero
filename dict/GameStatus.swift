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
    private var flashCardRepository: FlashCardRepository
    private var deckRepository: DeckRepository

    init(flashCardRepository: FlashCardRepository, deckRepository: DeckRepository) {
        self.flashCardRepository = flashCardRepository
        self.deckRepository = deckRepository
    }
    
    func save(name: String, color: String) {
        deckRepository.save(name: name, color: color)
    }
    
    func save(deck: Deck, name: String, color: String) {
        deckRepository.save(deck: deck, name: name, color: color)
    }
    
    func save(deck: Deck, word: String, translation: String) {
        if word.isEmpty {
            return
        }
        flashCardRepository.save(deck: deck, word: word, translation: translation)
    }
    
    func save(deck: Deck, flashCard: FlashCard) {
        flashCardRepository.save(deck: deck, flashCard: flashCard)
    }
    
    func delete(flashCard: FlashCard) {
        flashCardRepository.delete(flashCard: flashCard)
    }
    
    func delete(deck: Deck) {
        deckRepository.delete(deck: deck)
    }
    
    func loadDictionary() -> [Deck] {
        return deckRepository.getAll();
    }
}
