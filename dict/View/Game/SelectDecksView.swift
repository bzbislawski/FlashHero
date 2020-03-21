//
//  GameSheetView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 25/02/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct SelectDecksView: View {
    @Environment (\.presentationMode) var presentationMode
    @EnvironmentObject var gameStatus: GameStatus
    @EnvironmentObject var gamePlay: GamePlay
    
    var body: some View {
        NavigationView {
            List(self.gameStatus.decks, id: \.self) { deck in
                GameSheetRowView(deck: deck, isSelected: self.gamePlay.selectedDecks.contains(deck)) {
                    if self.gamePlay.selectedDecks.contains(deck) {
                        self.gamePlay.selectedDecks.removeAll(where: { $0 == deck })
                    }
                    else {
                        self.gamePlay.selectedDecks.append(deck)
                    }
                }
            }
            .navigationBarTitle("Select decks")
            .navigationBarItems(
                trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Dismiss")
                        .foregroundColor(Color.firstColor)
                        .font(.system(size: 18, weight: .semibold))
                })
            )
        }
    }
}

struct GameSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let repository = FlashCardRepository(moc: context)
        let repository2 = DeckRepository(moc: context)
        
        let gs = GameStatus(flashCardRepository: repository, deckRepository: repository2)
        
        let decks = gs.decks
        for deck in decks {
            gs.delete(deck: deck)
        }
        gs.save(name: "Kitchen", color: "yellow")
        try! context.save()
        
        return SelectDecksView().environmentObject(gs)
        
    }
}
