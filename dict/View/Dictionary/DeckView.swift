//
//  Deck.swift
//  dict
//
//  Created by Bartosz Zbislawski on 19/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct DeckView: View {
    @EnvironmentObject var gameStatus: GameStatus
    @Binding var showSheet: Bool
    @Binding var activeSheet: ActiveSheet
    @Binding var activeDeck: Deck?
    @Binding var activeFlashCard: FlashCard?
    var deck: Deck
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    @State private var showPlayButton = false
    
    var flashCards: [FlashCard] {
        return deck.flashCardArray
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.showSheet.toggle()
                    self.activeSheet = .deckEditForm
                    self.activeDeck = self.deck
                }) {
                    HStack {
                        Image(systemName: "folder")
                        Text(deck.wrappedName).font(.system(size: 20, weight: .semibold))
                    }
                    .padding(.leading, 20)
                    .foregroundColor(Color.darkBlue)
                }
                
                Spacer()
            }.padding(.top, 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(self.flashCards, id: \.self) { flashCard in
                        MiniFlashCardView(deck: self.deck, flashCard: flashCard).onTapGesture {
                            self.showSheet.toggle()
                            self.activeSheet = .flashCardEditForm
                            self.activeDeck = self.deck
                            self.activeFlashCard = flashCard
                        }
                        .frame(width: 160, height: 100)
                        .padding(.top, 5)
                        .padding(.bottom)
                        .padding(.trailing, 20)
                        .padding(.leading, 20)
                    }
                    Button(action: {
                        self.showSheet.toggle()
                        self.activeSheet = .flashCardForm
                        self.activeDeck = self.deck
                    }) {
                        Image(systemName: "plus.app")
                            .font(.system(size: 38, weight: .semibold))
                            .frame(width: 100, height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(style: StrokeStyle(lineWidth: 5, dash: [10, 5]))
                        )
                            .foregroundColor(.secondaryBackgroundColor)
                            .padding(.top, 5)
                            .padding(.bottom)
                            .padding(.trailing, 20)
                            .padding(.leading, 20)
                    }
                }
            }
        }
    }
    
}

struct DeckView_Previews: PreviewProvider {
    struct DeckViewWrapper: View {
        @State var showSheet = true
        @State var activeSheet: ActiveSheet = ActiveSheet.deckForm
        @State var activeDeck: Deck? = nil
        @State var activeFlashCard: FlashCard? =  nil
        var body: some View {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let repository = FlashCardRepository(moc: context)
            let repository2 = DeckRepository(moc: context)
            let gameStatus = GameStatus(flashCardRepository: repository, deckRepository: repository2)
            
            let deck = Deck(context: context)
            deck.name = "Deck name"
            deck.color = "blue"
            
            let flashCard = FlashCard(context: context)
            flashCard.word = "Kitchen"
            flashCard.translation = "Kuchnia"
            deck.addToFlashCard(flashCard)
            
            try? context.save()
            return DeckView(
                showSheet: self.$showSheet,
                activeSheet: self.$activeSheet,
                activeDeck: self.$activeDeck,
                activeFlashCard: self.$activeFlashCard, deck: deck
            ).environmentObject(gameStatus)
        }
    }
    
    static var previews: some View {
        DeckViewWrapper()
    }
}
