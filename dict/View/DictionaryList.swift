//
//  DictionaryList.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct DictionaryList: View {
//    @FetchRequest(entity: FlashCard.entity(), sortDescriptors: [
//        NSSortDescriptor(keyPath: \FlashCard.createdAt, ascending: true)
//    ]) var flashCards: FetchedResults<FlashCard>
//    @EnvironmentObject var gameStatus: GameStatus
//    @State private var showingFormView = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Dictionary()
                        Dictionary()
                        Dictionary()
                        Dictionary()
                    }
                }
            }.navigationBarTitle("Dictionary")
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
struct DictionaryList_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryList()
    }
}
//#endif
