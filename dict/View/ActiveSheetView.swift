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
    @ObservedObject private var keyboard = KeyboardResponder()
    @State private var currentPosition: CGSize = .zero
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.7).onTapGesture {
                self.showSheet = false
                self.activeSheetHandler.delayHideView()
            }.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                VStack {
                    if (self.activeSheetHandler.activeSheet == .deckForm) {
                        DeckFormView(showSheet: self.$showSheet)
                    } else {
                        FlashCardFormView(showSheet: self.$showSheet)
                    }
                }
                .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
                .frame(width: UIScreen.main.bounds.size.width)
                .background(Color.backgroundColor)
                .cornerRadius(25, corners: [.topLeft, .topRight])
                .offset(y: self.showSheet ? self.currentPosition.height : UIScreen.main.bounds.height)
                .animation(Animation.default)
                .gesture(DragGesture()
                .onChanged { value in
                    if value.translation.height > 0 {
                        self.currentPosition = CGSize(width: 0, height: value.translation.height)
                    }
                }
                .onEnded { value in
                    if value.translation.height < 100 {
                        self.currentPosition = CGSize.zero
                    } else {
                        self.showSheet = false
                        self.activeSheetHandler.delayHideView()
                    }
                })
            }
        }
        .padding(.bottom, keyboard.currentHeight)
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
