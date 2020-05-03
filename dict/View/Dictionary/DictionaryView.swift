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
                    .foregroundColor(Color.rgb(r: 52, g: 92, b: 157))
                    .font(.system(size: 32, weight: .bold))
                    .padding(.leading, 30)
                    .padding(.top, 70)
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 44, height: 44)
                    
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color.iconActive)
                            .padding(.trailing, 30)
                            .padding(.top, 70)
                            .font(.system(size: 24, weight: .bold))
                    }
                }
                Spacer()
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
