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
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    Image("rectangle")
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 320, height: 220)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(self.colorScheme == .light ? Color.white : Color.gray, lineWidth: 4))
                        .shadow(radius: 5)
                    Text("haha")
                }.offset(y: -30)
                ZStack {
                    Image("rectangle")
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 340, height: 220)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(self.colorScheme == .light ? Color.white : Color.gray, lineWidth: 4))
                        .shadow(radius: 5)
                    Text("haha")
                }
            }
        }
        
        
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
