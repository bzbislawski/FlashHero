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
    
    private enum LeadingButtonLabel {
        static let SELECT = "Select All     "
        static let DESELECT = "Deselect All"
    }
    
    var allDecksAreSelected: Bool {
        self.gamePlay.selectedDecks.count == self.gameStatus.dictionary.count
    }
    
    var body: some View {
        NavigationView {
            List(self.gameStatus.dictionary, id: \.self) { deck in
                GameSheetRowView(deck: deck, isSelected: self.gamePlay.selectedDecks.contains(deck)) {
                    if self.gamePlay.selectedDecks.contains(deck) {
                        self.gamePlay.selectedDecks.removeAll(where: { $0 == deck })
                    } else {
                        self.gamePlay.selectedDecks.append(deck)
                    }
                }
            }
            .navigationBarTitle("Select decks")
            .navigationBarItems(
                leading: Button(action: {
                    if self.allDecksAreSelected {
                        self.gamePlay.selectedDecks.removeAll()
                    } else {
                        self.gamePlay.selectedDecks.removeAll()
                        self.gameStatus.dictionary.forEach { deck in
                            self.gamePlay.selectedDecks.append(deck)
                        }
                    }
                }, label: {
                    Text(self.allDecksAreSelected ? LeadingButtonLabel.DESELECT : LeadingButtonLabel.SELECT)
                        .foregroundColor(Color.firstColor)
                        .font(.system(size: 18, weight: .semibold))
                }),
                trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Done")
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
        
        gs.save(name: "Kitchen", color: "yellow")
        try! context.save()
        
        return SelectDecksView().environmentObject(gs)
        
    }
}
