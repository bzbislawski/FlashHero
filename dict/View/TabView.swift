//
//  TabView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 16/03/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct TabView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var geometry: GeometryProxy
    
    var body: some View {
        VStack {            
            HStack {
                Spacer()
                Image(systemName: "book.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.geometry.size.width/5, height: 32)
                    .foregroundColor(self.viewRouter.currentView == Homepapge.dictionary ? .firstColor : .gray)
                    .onTapGesture {
                        self.viewRouter.currentView = Homepapge.dictionary
                }
                
                Image(systemName: "gamecontroller.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.geometry.size.width/5, height: 32)
                    
                    .foregroundColor(self.viewRouter.currentView == Homepapge.game ? .firstColor : .gray)
                    .onTapGesture {
                        self.viewRouter.currentView = Homepapge.game
                }
                
                Image(systemName: "gear")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.geometry.size.width/5, height: 32)
                    .foregroundColor(self.viewRouter.currentView == Homepapge.settings ? .firstColor : .gray)
                    .onTapGesture {
                        self.viewRouter.currentView = Homepapge.settings
                }
                
                Spacer()
            }
            .padding(.bottom, 10)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        let env = ViewRouter()
        return HomepageView().environmentObject(env)
    }
}
