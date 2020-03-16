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
                    Dictionary()
                } else if self.viewRouter.currentView == Homepapge.game {
                    GameView()
                } else if self.viewRouter.currentView == Homepapge.settings {
                    SettingsView()
                }
                TabView(geometry: geometry)
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
        HomepageView()
    }
}
