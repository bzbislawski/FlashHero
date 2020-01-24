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
//        newFlashCard.origin = deck
        newFlashCard.word = word
        newFlashCard.translation = translation
        newFlashCard.createdAt = Date()
        
        deck.addToFlashCard(newFlashCard)
        
        try? self.moc.save()
    }
    
    func delete(flashCard: FlashCard) {
        self.moc.delete(flashCard)
        try? self.moc.save()
    }
    
    func getAll() -> Array<FlashCard> {
        var fetchedResults: Array<Deck> = Array<Deck>()

        let fetchRequest : NSFetchRequest<Deck> = Deck.fetchRequest()
        let response: Array<FlashCard>
        
        do {
            fetchedResults = try  self.moc.fetch(fetchRequest)
            response = fetchedResults[0].flashCardArray
        } catch let fetchError as NSError {
            print("retrieveById error: \(fetchError.localizedDescription)")
            response = Array<FlashCard>()
        }
        
        return response
    }
}
