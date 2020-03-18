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

struct Dictionary: View {
    @EnvironmentObject var gameStatus: GameStatus
    @State private var showSheet = false
    @State private var activeSheet: ActiveSheet = .deckForm
    @State private var activeDeck: Deck?
    @State private var activeFlashCard: FlashCard?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Text("List of your saved decks.")
                            .italic()
                            .font(.subheadline)
                            .fontWeight(.ultraLight)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    Spacer()
                }
                if self.gameStatus.decks.isEmpty {
                    VStack {
                        Text("""
                        Oops, there are no decks here.
                        Try adding some to your dictionary...
                        """)
                            .italic()
                            .fixedSize(horizontal: false, vertical: true)
                            
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 50)
                        ZStack {
                            Circle()
                            .fill(Color.white)
                            .frame(width: 64, height: 44)
                            .opacity(1)
                            .shadow(color: .gray, radius: 8, x: 0, y: 30)
                        Image(systemName: "questionmark.diamond.fill")
                            .frame(width: 44, height: 44)
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(.firstColor)
                        }
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(self.gameStatus.decks, id: \.self) { deck in
                            DeckView(showSheet: self.$showSheet, activeSheet: self.$activeSheet, activeDeck: self.$activeDeck, activeFlashCard: self.$activeFlashCard, deck: deck)
                        }
                    }.padding(.top, 30)
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
                }).sheet(isPresented: $showSheet) {
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
            )
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
        
        return Dictionary().environmentObject(gameStatus)
    }
}
#endif
