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
            TabView {
                Dictionary()
                    .tabItem {
                        Image(systemName: "book")
                            .font(Font.title.weight(.light))
                        Text("Dictionary")
                }
                Game()
                    .tabItem {
                        Image(systemName: "gamecontroller").font(Font.title.weight(.light))
                        Text("Game")
                }
                .onAppear{ self.gameStatus.resetGame()}
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                            .font(Font.title.weight(.light))
                        Text("Settings")
                }
            }
            .accentColor(.firstColor)
            
        }
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
