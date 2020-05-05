//
//  Dictionary.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

enum ActiveSheet {
    case deckForm, flashCardForm, deckEditForm, flashCardEditForm
}

struct DictionaryView: View {
    @EnvironmentObject var gameStatus: GameStatus
    @State private var showSheet = false
    @State private var activeSheet: ActiveSheet = .deckForm
    @State private var activeDeck: Deck?
    @State private var activeFlashCard: FlashCard?    
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                HStack {
                    Text("Dictionary")
                        .foregroundColor(.fontColor)
                        .font(.system(size: 32, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {
                        self.showSheet.toggle()
                        self.activeSheet = .deckForm
                    }, label: {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 44, height: 44)
                            .overlay(
                                Image(systemName: "plus.circle")
                                    .foregroundColor(Color.iconActive)
                                    .padding(.trailing, 30)
                                    .padding(.top, 70)
                                    .font(.system(size: 24, weight: .bold))
                        )
                    })
                        .sheet(isPresented: $showSheet) {
                            if self.activeSheet == .deckForm {
                                DeckFormView().environmentObject(self.gameStatus)
                            } else if (self.activeSheet == .deckEditForm) {
                                DeckFormView(deck: self.activeDeck).environmentObject(self.gameStatus)
                            } else if (self.activeSheet == .flashCardForm) {
                                FlashCardFormView(deck: self.activeDeck!).environmentObject(self.gameStatus)
                            } else if (self.activeSheet == .flashCardEditForm) {
                                FlashCardFormView(deck: self.activeDeck!, flashCard: self.activeFlashCard).environmentObject(self.gameStatus)
                            }
                    }
                    
                }.padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 70)
                
                if self.gameStatus.loadDictionary().isEmpty {
                    Spacer()
                    VStack {
                        Image("dictionary_empty")
                        Text("Hey! It's empty here!")
                            .foregroundColor(.fontColor)
                    }
                    Spacer()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(self.gameStatus.loadDictionary(), id: \.self) { deck in
                            DeckView(showSheet: self.$showSheet, activeSheet: self.$activeSheet, activeDeck: self.$activeDeck, activeFlashCard: self.$activeFlashCard, deck: deck)
                        }
                    }
                }
            }
        }
    }
}

#if debug
struct Dictionary_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let repository = FlashCardRepository(moc: context)
        let repository2 = DeckRepository(moc: context)
        let gameStatus = GameStatus(flashCardRepository: repository, deckRepository: repository2)
        
        return DictionaryView().environmentObject(gameStatus)
    }
}
#endif
