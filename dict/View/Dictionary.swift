//
//  Dictionary.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

enum ActiveSheet {
    case first, second
}

struct Dictionary: View {
    @EnvironmentObject var gameStatus: GameStatus
    @FetchRequest(entity: Deck.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Deck.createdAt, ascending: true)
    ]) var decks: FetchedResults<Deck>
    @State private var showSheet = false
    @State private var activeSheet: ActiveSheet = .first
    @State private var activeDeck: Deck = Deck()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(decks, id: \.self) { deck in
                        VStack {
                            HStack {
                                Text(deck.wrappedName)
                                    .padding(.leading, 20)
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.lightGrayFont)
                                Spacer()
                            }.padding(.top, 20)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    DeckView(deck: deck)
                                    Button(action: {
                                        self.showSheet.toggle()
                                        self.activeSheet = .second
                                        self.activeDeck = deck
                                    }) {
                                        Image(systemName: "plus.app")
                                            .font(.system(size: 38, weight: .semibold))
                                            .frame(width: 100, height: 100)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .strokeBorder(style: StrokeStyle(lineWidth: 5, dash: [10, 5]))
                                            )
                                            .foregroundColor(.grayFont)
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
            }
            .navigationBarTitle(Text("Dictionary").foregroundColor(Color.blackFont))
            .navigationBarItems(
                trailing: Button(action: {
                    self.showSheet.toggle()
                    self.activeSheet = .first
                }, label: {
                    Image(systemName: "plus.app")
                        .frame(width: 44, height: 44)
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundColor(Color.firstColor)
                }).sheet(isPresented: $showSheet) {
                    if self.activeSheet == .first {
                        DeckFormView().environmentObject(self.gameStatus)
                    } else {
                        FlashCardFormView(deck: self.activeDeck).environmentObject(self.gameStatus)
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
