//
//  Deck+CoreDataProperties.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//
//

import Foundation
import CoreData


extension Deck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deck> {
        return NSFetchRequest<Deck>(entityName: "Deck")
    }

    @NSManaged public var id: UUID
    @NSManaged public var created_at: Date
    @NSManaged public var color: String
    @NSManaged public var name: String

}
