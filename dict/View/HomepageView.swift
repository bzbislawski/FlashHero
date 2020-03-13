//
//  Homepage.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct HomepageView: View {
    @ObservedObject var viewRouter = ViewRouter()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                if self.viewRouter.currentView == Homepapge.dictionary {
                    Dictionary()
                } else if self.viewRouter.currentView == Homepapge.game {
                    GameView()
                } else if self.viewRouter.currentView == Homepapge.settings {
                    SettingsView()
                }
                Spacer()
                
                HStack {
                    Spacer()
                    Image(systemName: "book.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/5, height: 32)
                        .foregroundColor(self.viewRouter.currentView == Homepapge.dictionary ? .firstColor : .gray)
                        .onTapGesture {
                            self.viewRouter.currentView = Homepapge.dictionary
                    }
                    
                    Image(systemName: "gamecontroller.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/5, height: 32)

                        .foregroundColor(self.viewRouter.currentView == Homepapge.game ? .firstColor : .gray)
                        .onTapGesture {
                            self.viewRouter.currentView = Homepapge.game
                    }
                    
                    Image(systemName: "gear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width/5, height: 32)
                        .foregroundColor(self.viewRouter.currentView == Homepapge.settings ? .firstColor : .gray)
                        .onTapGesture {
                            self.viewRouter.currentView = Homepapge.settings
                    }
                    
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height/10)
                .background(Color.white.shadow(radius: 2))
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
