//
//  Dictionary.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct Dictionary: View {
    @FetchRequest(entity: Deck.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Deck.createdAt, ascending: true)
    ]) var decks: FetchedResults<Deck>
//    @EnvironmentObject var gameStatus: GameStatus
//    @State private var showingFormView = false
    @State private var showingFormView = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(decks, id: \.self) { deck in
                            DeckView()
                        }
                    }
                }
            }.navigationBarTitle("Dictionary")
            .navigationBarItems(
                trailing: Button(action:{ self.showingFormView = true }) {
                Image(systemName: "plus.app")
                    .frame(width: 44, height: 44)
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundColor(Color("GreenFont"))
                
            })
        }
    }
    
//    func removeFlashCard(at offsets: IndexSet) {
//        for index in offsets {
//            let flashCard = flashCards[index]
//            self.gameStatus.delete(flashCard: flashCard)
//        }
//    }
}

//#if debug
struct Dictionary_Previews: PreviewProvider {
    static var previews: some View {
        Dictionary()
    }
}
//#endif
