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
    @State private var showSheet = false
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.7).onTapGesture {
                self.showSheet = false
                self.activeSheetHandler.delayHideView()
            }
            
            VStack {
                Spacer()
                VStack {
                    if (self.activeSheetHandler.activeSheet == .deckForm) {
                        DeckFormView(showSheet: self.$showSheet)
                    } else {
                        FlashCardFormView()
                    }
                }
                .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
                .frame(width: UIScreen.main.bounds.size.width)
                .background(Color.backgroundColor)
                .offset(y: self.showSheet ? 0 : UIScreen.main.bounds.height)
                .cornerRadius(25, corners: [.topLeft, .topRight])
                .animation(Animation.default)
            }
        }
        .onAppear {
            self.showSheet = true
        }
    }
}

struct ActiveSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveSheetView()
    }
}
