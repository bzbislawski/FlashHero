//
//  FlashCardDeckView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 23/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct FlashCardDeckView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ZStack {
            Image("rectangle")
                .resizable()
                .cornerRadius(10)
                .frame(width: 320, height: 220)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(self.colorScheme == .light ? Color.white : Color.gray, lineWidth: 4))
                .shadow(radius: 5)
            
            Text("self.word")
                .bold()
                .font(.title)
        }
    }
}

struct FlashCardDeckView_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
