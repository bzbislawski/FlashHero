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
    case deckForm, flashCardForm, vocabulary, cardsOrder
}

class ActiveSheetHandler: ObservableObject {
    @Published var showSheet = false
    @Published var activeSheet: ActiveSheet?
    @Published var activeDeck: Deck?
    @Published var activeFlashCard: FlashCard?
    
    public func delayHideView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.showSheet = false
        }
    }
}
