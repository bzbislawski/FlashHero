//
//  Dictionary.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

enum ActiveSheet {
    case deckForm, flashCardForm, flashCardEditForm
}

struct Dictionary: View {
    @EnvironmentObject var gameStatus: GameStatus
    @FetchRequest(entity: Deck.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Deck.createdAt, ascending: true)
    ]) var decks: FetchedResults<Deck>
    @State private var showSheet = false
    @State private var activeSheet: ActiveSheet = .deckForm
    @State private var activeDeck: Deck = Deck()
    @State private var activeFlashCard: FlashCard = FlashCard()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(decks, id: \.self) { deck in
                        DeckView(showSheet: self.$showSheet, activeSheet: self.$activeSheet, activeDeck: self.$activeDeck, activeFlashCard: self.$activeFlashCard, deck: deck)
                    }
                }
            }
            .navigationBarTitle("Dictionary")
            .navigationBarItems(
                trailing: Button(action: {
                    self.showSheet.toggle()
                    self.activeSheet = .deckForm
                }, label: {
                    Image(systemName: "plus.app")
                        .frame(width: 44, height: 44)
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundColor(Color.firstColor)
                }).sheet(isPresented: $showSheet) {
                    if self.activeSheet == .deckForm {
                        DeckFormView().environmentObject(self.gameStatus)
                    } else if (self.activeSheet == .flashCardForm) {
                        FlashCardFormView(deck: self.activeDeck).environmentObject(self.gameStatus)
                    } else {
                        FlashCardEditFormView(flashCard: self.activeFlashCard)
                    }
                }
            )
        }
    }
}

//#if debug
struct Dictionary_Previews: PreviewProvider {
    static var previews: some View {
        Dictionary()
    }
}
//#endif
