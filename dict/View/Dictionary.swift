//
//  Dictionary.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct Dictionary: View {
    @FetchRequest(entity: FlashCard.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \FlashCard.createdAt, ascending: true)
    ]) var flashCards: FetchedResults<FlashCard>
    @EnvironmentObject var gameStatus: GameStatus
    @State private var showingFormView = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(flashCards, id: \.word) { flashCard in
                    NavigationLink(destination: FormEditView(flashCard: flashCard)) {
                        VStack(alignment: .leading) {
                            Text(flashCard.word).font(.headline)
                            Text(flashCard.translation).font(.subheadline).foregroundColor(Color.gray)
                        }
                    }
                }.onDelete(perform: removeFlashCard)
                NavigationLink(destination: FormAddView(), isActive: self.$showingFormView){ EmptyView()
                }
                .frame(width: 0, height: 0)
                .disabled(true)
            }
            .navigationBarTitle("Dictionary")
            .navigationBarItems(
                trailing: Button(action:{ self.showingFormView = true }) {
                    Image(systemName: "plus.circle.fill")
                        .frame(width: 44, height: 44)
                        .font(.system(size: 22, weight: .medium))
            })
        }
    }
    
    func removeFlashCard(at offsets: IndexSet) {
        for index in offsets {
            let flashCard = flashCards[index]
            self.gameStatus.delete(flashCard: flashCard)
        }
    }
}

#if debug
struct Dictionary_Previews: PreviewProvider {
    static var previews: some View {
        Dictionary()
    }
}
#endif
