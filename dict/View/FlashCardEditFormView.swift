//
//  FlashCardEditFormView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FlashCardEditFormView: View {
    @EnvironmentObject var gameStatus: GameStatus
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var flashCard: FlashCard
    @State private var word: String = ""
    @State private var translation: String = ""
    
    
    var body: some View {
        return Form {
            Section(header: Text("Word & translation")) {
                TextField("Word", text: $word).onAppear {
                    self.word = self.flashCard.wrappedWord
                }
                TextField("Translation", text: $translation).onAppear {
                    self.translation = self.flashCard.wrappedTranslation
                }
            }
            
            Section(header: Text("Manage")) {
                Button(action:{
                    self.gameStatus.delete(flashCard: self.flashCard)
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
//                    self.gameStatus.save(word: self.word, translation: self.translation)
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.system(size: 18))
            }
        )
        
    }
}

struct FlashCardEditFormView_Previews: PreviewProvider {
    static var previews: some View {
        let flashCard = FlashCard()
        flashCard.word = "word"
        flashCard.translation = "trans"
        return FlashCardEditFormView(flashCard: flashCard)
    }
}
