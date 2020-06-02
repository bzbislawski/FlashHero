//
//  MiniFlashCardView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 26/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct MiniFlashCardView: View {
    @EnvironmentObject var gameStatus: GameStatus
    var deck: Deck
    var flashCard: FlashCard?
    
    var miniFlashCardColor: String {
        self.gameStatus.dictionary.filter({ return $0.id == deck.id }).first?.wrappedColor ?? ""
    }
    
    var deckColor: DeckColor {
        deckColors.filter({return $0.name == self.miniFlashCardColor}).first ?? deckColors.first!
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [deckColor.colorOne, deckColor.colorTwo]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(10)
                // TODO: Delete?
//                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 4))
//                .shadow(radius: 5, x: 0, y: 4)
            
            Text(flashCard != nil ? flashCard!.wrappedWord : "")
                .bold()
                .font(.system(size: 22))
                .foregroundColor(Color.white)
                .frame(maxWidth: 280)
                .shadow(radius: 10)
        }
    }
}

struct MiniFlashCardView_Previews: PreviewProvider {
    static var previews: some View {
        MiniFlashCardView(deck: Deck(), flashCard: FlashCard())
    }
}
