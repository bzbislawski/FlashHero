//
//  FormEditView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FormEditView: View {
    @ObservedObject var flashCard: FlashCard
    
    var body: some View {
        Form {
            Section(header: Text("Word")) {
                TextField(" Enter some word here...", text: $flashCard.word)
            }
            Section(header: Text("Translation")) {
                TextField(" Enter the translation here...", text: $flashCard.translation)
            }.navigationBarTitle("Edit word")
        }
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
