//
//  FormView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FormAddView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var word: String = ""
    @State private var translation: String = ""
    
    
    var body: some View {
        Form {
            Section(header: Text("Word")) {
                TextField(" Enter some word here...", text: $word)
            }
            Section(header: Text("Translation")) {
                TextField(" Enter the translation here...", text: $translation)
            }
        }
        .navigationBarTitle("Add word")
        .navigationBarItems(trailing:
            HStack {
                Button("Done") {
                    if (self.word == "") {
                        self.presentationMode.wrappedValue.dismiss()
                        return
                    }
                    let newFlashCard = FlashCard(context: self.moc)
                    newFlashCard.word = self.word
                    newFlashCard.translation = self.translation
                    
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        )
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormAddView()
    }
}
