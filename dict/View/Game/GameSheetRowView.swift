//
//  GameSheetRowView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 25/02/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct GameSheetRowView: View {
    var deck: Deck
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                MiniFlashCardView(deck: deck).frame(width: 64, height: 64)
                Text(deck.wrappedName).font(.headline).padding(.leading, 20)
                Spacer()
                Image(systemName: "checkmark.circle")
                    .font(Font.title.weight(.light))
                    .foregroundColor(self.isSelected ? Color.firstColor : Color.gray)
                    .padding(.trailing, 10)
            }
        }
    }
}

struct GameSheetRowView_Previews: PreviewProvider {
    static var previews: some View {
        GameSheetRowView(deck: Deck(), isSelected: true, action: {})
    }
}
