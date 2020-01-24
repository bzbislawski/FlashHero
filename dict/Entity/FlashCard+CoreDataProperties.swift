//
//  FlashCard+CoreDataProperties.swift
//  dict
//
//  Created by Bartosz Zbislawski on 24/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//
//

import Foundation
import CoreData


extension FlashCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashCard> {
        return NSFetchRequest<FlashCard>(entityName: "FlashCard")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var translation: String?
    @NSManaged public var word: String?
    @NSManaged public var origin: Deck?
    
    public var wrappedWord: String {
        word ?? "Unknown word"
    }
    
    public var wrappedTranslation: String {
        translation ?? "Unknown word"
    }

}
