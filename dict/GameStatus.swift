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
    @Published var flashCardsCount: Int = 0
    @Published var answers: Int = 0
    
    var moc: NSManagedObjectContext

    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func fetchAllFlashCards() -> Array<FlashCard> {
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
