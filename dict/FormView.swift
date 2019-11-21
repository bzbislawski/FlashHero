//
//  FormView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FormView: View {
    @Environment(\.managedObjectContext) var moc
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
                        return
                    }
                    let newFlashCard = FlashCard(context: self.moc)
                    newFlashCard.word = self.word
                    newFlashCard.translation = self.translation
                    
                    do {
                        try self.moc.save()
                    } catch {
                        fatalError("Whoops! \(error.localizedDescription)")
                    }
                }
            }
        )
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
