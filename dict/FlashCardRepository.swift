//
//  FlashCardRepository.swift
//  dict
//
//  Created by Bartosz Zbislawski on 27/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import Foundation
import CoreData

class FlashCardRepository {
   
    var moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func save(deck: Deck, word: String, translation: String) {
        
        let newFlashCard = FlashCard(context: self.moc)
        newFlashCard.word = word
        newFlashCard.translation = translation
        newFlashCard.createdAt = Date()
        
        deck.addToFlashCard(newFlashCard)
        
        try? self.moc.save()
    }
    
    func save(deck: Deck, flashCard: FlashCard) {
        deck.addToFlashCard(flashCard)
        
        try? self.moc.save()
    }
    
    func delete(flashCard: FlashCard) {
        self.moc.delete(flashCard)
        try? self.moc.save()
    }
    
    func getAll() -> Array<Deck> {
        var fetchedResults: Array<Deck> = Array<Deck>()
        let deckFetchRequest : NSFetchRequest<Deck> = Deck.fetchRequest()
        
        do {
            fetchedResults = try self.moc.fetch(deckFetchRequest)
        } catch let fetchError as NSError {
            print("retrieveById error: \(fetchError.localizedDescription)")
        }
        
        return fetchedResults
    }
}
