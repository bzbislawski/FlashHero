//
//  Dictionary.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct DictionaryView: View {
    @EnvironmentObject var gameStatus: GameStatus
    @EnvironmentObject var activeSheetHandler: ActiveSheetHandler
    
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
                        self.activeSheetHandler.showSheet.toggle()
                        self.activeSheetHandler.activeSheet = .deckForm
                    }, label: {
                        ZStack{
                            Circle()
                                .fill(Color.white)
                                .frame(width: 44)
                                .shadow(color: .fontColor, radius: 4, x: 3, y: 3)
                                .shadow(color: .white, radius: 4, x: -3, y: -3)
                            Image(systemName: "plus.circle")
                                .foregroundColor(Color.iconActive)
                                .font(.system(size: 24, weight: .bold))
                        }
                    })
                }
                .frame(maxHeight: 44)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.top, 60)
                
                if self.gameStatus.loadDictionary().isEmpty {
                    Spacer()
                    VStack {
                        Image("dictionary_empty")
                        Text("Hey! It's empty here!")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(Color.fontColor)
                            .padding(.top, 20)
                        Text("You haven’t added any decks\nyet. Add some decks and\nflashcards!")
                            .fixedSize()
                            .multilineTextAlignment(.center)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.fontColor)
                            .padding(.top, 20)
                    }
                    Spacer()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(self.gameStatus.loadDictionary(), id: \.self) { deck in
                            DeckView(deck: deck)
                        }
                    }
                }
            }
        }
    }
}

//#if debug
struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let repository = FlashCardRepository(moc: context)
        let repository2 = DeckRepository(moc: context)
        let gameStatus = GameStatus(flashCardRepository: repository, deckRepository: repository2)
        
        return DictionaryView().environmentObject(gameStatus)
    }
}
//#endif
