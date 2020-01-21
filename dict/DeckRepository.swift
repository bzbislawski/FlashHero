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
        let deck = Deck(context: self.moc)
        deck.name = name
        deck.color = color
        deck.createdAt = Date()
        
        try? self.moc.save()
    }
}
