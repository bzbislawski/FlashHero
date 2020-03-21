//
//  Homepage.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct HomepageView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if self.viewRouter.currentView == Homepapge.dictionary {
                    DictionaryView()
                } else if self.viewRouter.currentView == Homepapge.game {
                    GameView()
                } else if self.viewRouter.currentView == Homepapge.settings {
                    SettingsView()
                }
                Divider()
                TabView(geometry: geometry)
                    .frame(height: geometry.size.height * 0.1)
            }
            .edgesIgnoringSafeArea(.bottom)
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

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let repository = FlashCardRepository(moc: context)
        let repository2 = DeckRepository(moc: context)
        let gameStatus = GameStatus(flashCardRepository: repository, deckRepository: repository2)
        let env = ViewRouter()
        return HomepageView().environmentObject(env).environmentObject(gameStatus)
    }
}
