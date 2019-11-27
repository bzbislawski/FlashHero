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
    
    
    func save(word: String, translation: String) {
        let newFlashCard = FlashCard(context: self.moc)
        newFlashCard.word = word
        newFlashCard.translation = translation
        newFlashCard.createdAt = Date()
        
        try? self.moc.save()
    }
    
    func delete(flashCard: FlashCard) {
        self.moc.delete(flashCard)
        try? self.moc.save()
    }
    
    func getAll() -> Array<FlashCard> {
        var fetchedResults: Array<FlashCard> = Array<FlashCard>()

        let fetchRequest : NSFetchRequest<FlashCard> = FlashCard.fetchRequest()

        do {
            fetchedResults = try  self.moc.fetch(fetchRequest)
        } catch let fetchError as NSError {
            print("retrieveById error: \(fetchError.localizedDescription)")
            fetchedResults = Array<FlashCard>()
        }
        
        return fetchedResults
    }
}
