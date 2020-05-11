//
//  ActiveSheetHandler.swift
//  dict
//
//  Created by Bartosz Zbislawski on 10/05/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import Foundation
import SwiftUI

enum ActiveSheet {
    case deckForm, flashCardForm, deckEditForm, flashCardEditForm
}

enum ActiveStartGameSheet {
    case vocabulary, cardsOrder
}

class ActiveSheetHandler: ObservableObject {
    @Published var showSheet = false
    @Published var activeSheet: ActiveSheet = .deckForm
    @Published var activeDeck: Deck?
    @Published var activeFlashCard: FlashCard?
}
