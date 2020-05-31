//
//  TabView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 16/03/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct TabView: View {
    @EnvironmentObject var gamePlay: GamePlay
    @EnvironmentObject var viewRouter: ViewRouter
    @State var showsAlert = false
    @State var redirectTo = Homepage.dictionary
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                if self.gamePlay.isGameStarted {
                    self.showsAlert = true
                    self.redirectTo = Homepage.dictionary
                } else {
                    self.viewRouter.updateView(tabName: Homepage.dictionary)
                }
            }, label: {
                Image(systemName: "book.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width / 5, height: 32)
                    .foregroundColor(self.viewRouter.currentView == Homepage.dictionary ? .iconActive : .iconInactive)
            })
            
            Spacer()
            
            Button(action: {
                self.viewRouter.updateView(tabName: Homepage.game)
            }, label: {
                Image(systemName: "gamecontroller.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width / 5, height: 32)
                    .foregroundColor(self.viewRouter.currentView == Homepage.game ? .iconActive : .iconInactive)
            })
            
            Spacer()
        }
        .padding(.bottom, 10)
        .alert(isPresented: $showsAlert, content: { () -> Alert in
            Alert(title: Text("Leave the game?"), message: Text("All the progress will not be saved."),
                  primaryButton: .default(Text("Yes"), action: {
                    self.gamePlay.stop()
                    self.gamePlay.reset()
                    self.viewRouter.updateView(tabName: self.redirectTo)
                  }),
                  secondaryButton: .default(Text("Cancel")))
        })
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        let env = ViewRouter()
        return HomepageView().environmentObject(env)
    }
}
