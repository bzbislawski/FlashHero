//
//  Homepage.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct Homepage: View {
    @EnvironmentObject var gameStatus: GameStatus
    
    
    
    var body: some View {
        ZStack {
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
            TabView {
                Game()
                    .tabItem {
                        Image(systemName: "gamecontroller") .font(Font.title.weight(.light))
                        Text("Game")
                }
                .onAppear{ self.gameStatus.resetGame()}
                Dictionary()
                    .tabItem {
                        Image(systemName: "book")
                            .font(Font.title.weight(.light))
                        Text("Dictionary")
                }
                SettingsView()
                    .tabItem {
                        Image(systemName: "info.circle")
                            .font(Font.title.weight(.light))
                        Text("About")
                }
            }
            .accentColor(.firstColor)
            
        }
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.shadowColor = .clear
        standardAppearance.backgroundColor = .backgroundColor
        
        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.shadowColor = .clear
        compactAppearance.backgroundColor = .backgroundColor
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.shadowColor = .clear
        scrollEdgeAppearance.backgroundColor = .backgroundColor
        
        navigationBar.standardAppearance = standardAppearance
        navigationBar.compactAppearance = compactAppearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
    }
}

extension UITabBarController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let standardAppearance = UITabBarAppearance()
        
        standardAppearance.backgroundColor = .backgroundColor
        
        tabBar.standardAppearance = standardAppearance
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
