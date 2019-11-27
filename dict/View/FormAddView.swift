//
//  FormView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FormAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var word: String = ""
    @State private var translation: String = ""
    
    @EnvironmentObject var gameStatus: GameStatus
    
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
                    self.gameStatus.save(word: self.word, translation: self.translation)
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.system(size: 18))
            }
        )
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormAddView()
    }
}
