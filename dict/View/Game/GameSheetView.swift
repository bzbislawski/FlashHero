//
//  GameSheetView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 25/02/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct GameSheetView: View {
    @EnvironmentObject var gameStatus: GameStatus
    @State var selections: [Deck] = []
    
    var body: some View {
        NavigationView {
            List(self.gameStatus.decks, id: \.self) { deck in
                GameSheetRowView(deck: deck, isSelected: self.selections.contains(deck)) {
                    if self.selections.contains(deck) {
                        self.selections.removeAll(where: { $0 == deck })
                    }
                    else {
                        self.selections.append(deck)
                    }
                    print(self.selections.count)
                }
            }.navigationBarTitle("Select decks")
        }
    }
}

//struct GameSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let repository = FlashCardRepository(moc: context)
//        let repository2 = DeckRepository(moc: context)
//        
//        let gs = GameStatus(flashCardRepository: repository, deckRepository: repository2)
//        
//        //        gs.save(name: "beka", color: "")
//        let decks = gs.decks
//        for deck in decks {
//            gs.delete(deck: deck)
//        }
//        gs.save(name: "Kitchen", color: "yellow")
//        try! context.save()
//        
//        return GameSheetView(isSelected: true).environmentObject(gs)
//        
//    }
//}
