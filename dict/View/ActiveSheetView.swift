//
//  ActiveSheetView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 09/05/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct ActiveSheetView: View {
    @EnvironmentObject var activeSheetHandler: ActiveSheetHandler
    
    var body: some View {
        return VStack {
            if (self.activeSheetHandler.activeSheet == .deckForm) {
                DeckFormView()
            } else {
                FlashCardFormView()
            }
        }.padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
    }
}

struct ActiveSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveSheetView()
    }
}
