//
//  GameSheetView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 25/02/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct GameSheetView: View {
    @EnvironmentObject var gameStatus: GameStatus
    
    var body: some View {
        NavigationView {
            List(self.gameStatus.decks, id: \.self) { deck in
                HStack {
                    MiniFlashCardView(deck: deck).frame(width: 80, height: 80)
                    Text(deck.wrappedName).font(.headline).padding(.leading, 20)
                    Spacer()
                    Image(systemName: "checkmark.circle")
                        .font(Font.title.weight(.light))
                        .foregroundColor(Color.firstColor)
                }
            }.navigationBarTitle("Select decks")
        }
    }
}

struct GameSheetView_Previews: PreviewProvider {
    static var previews: some View {
        GameSheetView()
    }
}
