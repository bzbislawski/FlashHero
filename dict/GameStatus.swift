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
    @Published var deck: Deck?
    @Published var flashCards: Array<FlashCard> = []
    
    private var flashCardRepository: FlashCardRepository
    private var deckRepository: DeckRepository

    init(flashCardRepository: FlashCardRepository, deckRepository: DeckRepository) {
        self.flashCardRepository = flashCardRepository
        self.deckRepository = deckRepository
    }
    
    func save(deck: Deck, word: String, translation: String) {
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
        deckRepository.delete(deck: deck)
        if let currentDeck = self.deck {
            if currentDeck.id == deck.id {
                restackDeck()
            }
        }
    }
    
    func save(name: String, color: String) {
        deckRepository.save(name: name, color: color)
    }
    
    func save(deck: Deck, name: String, color: String) {
        deckRepository.save(deck: deck, name: name, color: color)
    }
    
    func restackDeck() {
        let decks = flashCardRepository.getAll()
        if (!decks.isEmpty) {
            self.deck = decks[0]
            self.flashCards = decks[0].flashCardArray
        } else {
            self.deck = nil
            self.flashCards = Array<FlashCard>()
        }
    }
    
    func resetGame() {
        self.correctAnswers = 0
        self.wrongAnswers = 0
        self.flashCards = self.deck?.flashCardArray ?? Array<FlashCard>()
    }
}
