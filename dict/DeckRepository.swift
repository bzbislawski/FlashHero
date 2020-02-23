//
//  DeckRepository.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import Foundation
import CoreData

class DeckRepository {
    var moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func save(name: String, color: String) {
        if name == "" {
            return
        }
        
        let deck = Deck(context: self.moc)
        deck.name = name
        deck.color = color != "" ? color : "blue"
        deck.createdAt = Date()
        deck.id = UUID()
        
        try? self.moc.save()
    }
    
    func save(deck: Deck, name: String, color: String) {
        deck.name = name
        deck.color = color
        
        try? self.moc.save()
    }
    
    func delete(deck: Deck) {
        self.moc.delete(deck)
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
