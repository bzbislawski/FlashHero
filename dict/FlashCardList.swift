//
//  FlashCardList.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FlashCardList: View {
    @FetchRequest(entity: FlashCard.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \FlashCard.word, ascending: true)
    ]) var flashCards: FetchedResults<FlashCard>
    
    var body: some View {
        List {
            ForEach(flashCards, id: \.word) { flashCard in
                Text(flashCard.word)
            }
        }.navigationBarTitle("Dictionary")
    }
}

struct FlashCardList_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardList()
    }
}
