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
    var geometry: GeometryProxy
    @State var showsAlert = false
    @State var redirectTo = Homepapge.dictionary
    
    var body: some View {
        VStack {            
            HStack {
                Spacer()
                Button(action: {
                    if self.gamePlay.isGameStarted {
                        self.showsAlert = true
                        self.redirectTo = Homepapge.dictionary
                    } else {
                        self.viewRouter.updateView(tabName: Homepapge.dictionary)
                    }
                }, label: {
                    Image(systemName: "book.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: self.geometry.size.width/5, height: 32)
                        .foregroundColor(self.viewRouter.currentView == Homepapge.dictionary ? .firstColor : .gray)
                })
                
                Button(action: {
                    self.viewRouter.updateView(tabName: Homepapge.game)
                }, label: {
                    Image(systemName: "gamecontroller.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: self.geometry.size.width/5, height: 32)
                        .foregroundColor(self.viewRouter.currentView == Homepapge.game ? .firstColor : .gray)
                })
                
                Button(action: {
                    if self.gamePlay.isGameStarted {
                        self.showsAlert = true
                        self.redirectTo = Homepapge.settings
                    } else {
                        self.viewRouter.updateView(tabName: Homepapge.settings)
                    }
                }, label: {
                    Image(systemName: "gear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: self.geometry.size.width/5, height: 32)
                        .foregroundColor(self.viewRouter.currentView == Homepapge.settings ? .firstColor : .gray)
                })
                
                Spacer()
            }
            .padding(.bottom, 10)
            .alert(isPresented: $showsAlert, content: { () -> Alert in
                Alert(title: Text("Leave the game?"), message: Text("All the progress will not be saved."),
                      primaryButton: .default(Text("Yes"), action: {
                        self.viewRouter.updateView(tabName: self.redirectTo)
                      }),
                      secondaryButton: .default(Text("Cancel")))
            })
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        let env = ViewRouter()
        return HomepageView().environmentObject(env)
    }
}
