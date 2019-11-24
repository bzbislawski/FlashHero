//
//  FormEditView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FormEditView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var flashCard: FlashCard
    @State private var word: String = ""
    @State private var translation: String = ""
    
    
    var body: some View {
        return Form {
            Section(header: Text("Word & translation")) {
                TextField("Word", text: $word).onAppear() {
                    self.word = self.flashCard.word
                }
                TextField("Translation", text: $translation).onAppear() {
                    self.translation = self.flashCard.translation
                }
            }
            
            Section(header: Text("Manage")) {
                Button(action:{
                    self.moc.delete(self.flashCard)
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Delete").foregroundColor(Color.red)
                }
            }
        }
        .navigationBarTitle("Edit word")
        .navigationBarItems(trailing:
            HStack {
                Button("Done") {
                    self.flashCard.word = self.word
                    self.flashCard.translation = self.translation
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.system(size: 18))
            }
        )
        
    }
}

struct FormEditView_Previews: PreviewProvider {
    static var previews: some View {
        let flashCard = FlashCard()
        flashCard.word = "word"
        flashCard.translation = "trans"
        return FormEditView(flashCard: flashCard)
    }
}
