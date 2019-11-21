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
        NSSortDescriptor(keyPath: \FlashCard.word, ascending: true)
    ]) var flashCards: FetchedResults<FlashCard>
    
    @Environment(\.managedObjectContext) var moc
    @State private var showingFormView = false
    
    var body: some View {
        
        VStack {
            List {
                ForEach(flashCards, id: \.word) { flashCard in
                    NavigationLink(destination: FormEditView(flashCard: flashCard)) {
                        Text(flashCard.word)
                    }
                }.onDelete(perform: removeFlashCard)
            }
            .navigationBarTitle("Dictionary")
            NavigationLink(destination: FormAddView(), isActive: self.$showingFormView){ EmptyView()
            }
            .frame(width: 0, height: 0)
            .disabled(true)
        }
        .navigationBarItems(
            trailing: Button(action:{ self.showingFormView = true }) {
                Image(systemName: "plus.circle.fill")
            }
        )
    }
    
    func removeFlashCard(at offsets: IndexSet) {
        for index in offsets {
            let flashCard = flashCards[index]
            moc.delete(flashCard)
        }
    }
}

struct Dictionary_Previews: PreviewProvider {
    static var previews: some View {
        Dictionary()
    }
}
