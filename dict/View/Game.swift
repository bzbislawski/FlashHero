//
//  Game.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct Game: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var showAnswer = false
    
    
    var body: some View {
        ZStack {
            FlashCardDeckView().offset(y: -100).scaleEffect(0.80)
            FlashCardDeckView().offset(y: -75).scaleEffect(0.85)
            FlashCardDeckView().offset(y: -50).scaleEffect(0.90)
            FlashCardDeckView().offset(y: -25).scaleEffect(0.95)
            FlashCardView(showAnswer: self.$showAnswer, word: "Mietek", translation: "Piesel")
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
