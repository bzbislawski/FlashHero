//
//  Deck+CoreDataProperties.swift
//  dict
//
//  Created by Bartosz Zbislawski on 24/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//
//

import Foundation
import CoreData


extension Deck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deck> {
        return NSFetchRequest<Deck>(entityName: "Deck")
    }

    @NSManaged public var color: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var flashCard: NSSet?
    
    public var wrappedColor: String {
        color ?? "Unknown color"
    }
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    
    public var flashCardArray: [FlashCard] {
        let set = flashCard as? Set<FlashCard> ?? []
        
        return set.sorted { $0.wrappedWord < $1.wrappedWord }
    }

}

// MARK: Generated accessors for flashCard
extension Deck {

    @objc(addFlashCardObject:)
    @NSManaged public func addToFlashCard(_ value: FlashCard)

    @objc(removeFlashCardObject:)
    @NSManaged public func removeFromFlashCard(_ value: FlashCard)

    @objc(addFlashCard:)
    @NSManaged public func addToFlashCard(_ values: NSSet)

    @objc(removeFlashCard:)
    @NSManaged public func removeFromFlashCard(_ values: NSSet)

}
