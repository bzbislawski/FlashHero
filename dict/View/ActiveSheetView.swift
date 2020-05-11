//
//  ActiveSheetView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 09/05/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct ActiveSheetView: View {
    @EnvironmentObject var activeSheetHandler: ActiveSheetHandler
    
    var body: some View {
        VStack {
            
            DeckFormView()
        }.padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        
//        if self.activeSheetHandler.activeSheet == .deckForm {
//            return DeckFormView()
//        } else if (self.activeSheetHandler.activeSheet == .deckEditForm) {
//            return DeckFormView(deck: self.activeSheetHandler.activeDeck)
//        } else if (self.activeSheetHandler.activeSheet == .flashCardForm) {
//            return FlashCardFormView(deck: self.activeSheetHandler.activeDeck!)
//        } else if (self.activeSheetHandler.activeSheet == .flashCardEditForm) {
//            return FlashCardFormView(deck: self.activeSheetHandler.activeDeck!, flashCard: self.activeSheetHandler.activeFlashCard)
//        }
    }
}

struct ActiveSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveSheetView()
    }
}
