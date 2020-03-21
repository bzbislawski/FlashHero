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
    @Published var deck: Deck?
    @Published var decks: Array<Deck> = []
    @Published var flashCards: Array<FlashCard> = []
    
    private var flashCardRepository: FlashCardRepository
    private var deckRepository: DeckRepository

    init(flashCardRepository: FlashCardRepository, deckRepository: DeckRepository) {
        self.flashCardRepository = flashCardRepository
        self.deckRepository = deckRepository
    }
    
    func save(name: String, color: String) {
        deckRepository.save(name: name, color: color)
        loadDictionary()
    }
    
    func save(deck: Deck, name: String, color: String) {
        deckRepository.save(deck: deck, name: name, color: color)
        loadDictionary()
    }
    
    func save(deck: Deck, word: String, translation: String) {
        if word.isEmpty {
            return
        }
        flashCardRepository.save(deck: deck, word: word, translation: translation)
        if self.deck == nil {
            self.deck = deck
            self.flashCards = deck.flashCardArray
        }
    }
    
    func save(deck: Deck, flashCard: FlashCard) {
        flashCardRepository.save(deck: deck, flashCard: flashCard)
    }
    
    func delete(flashCard: FlashCard) {
        flashCardRepository.delete(flashCard: flashCard)
    }
    
    func delete(deck: Deck) {
        self.decks = self.decks.filter { $0 != deck }
        deckRepository.delete(deck: deck)
    }
    
    func loadDictionary() {
        self.decks = deckRepository.getAll()
    }
}
