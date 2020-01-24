//
//  DeckFormView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 21/01/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct DeckFormView: View {
    @Environment (\.presentationMode) var presentationMode
    @State private var name: String = ""
    
    @EnvironmentObject var gameStatus: GameStatus
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.secondaryBackgroundColor.edgesIgnoringSafeArea(.all)
                VStack(spacing: 60) {
                    VStack {
                        Image(systemName: "book")
                            .frame(width: 32, height: 32)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color("GreenFont"))
                        Text("Deck")
                            .foregroundColor(Color("GreenFont"))
                            .font(.system(size: 32, weight: .bold))
                    }.padding(.top, 60)
                    VStack {
                        HStack {
                            Text("Deck name")
                                .foregroundColor(Color("GreenFont"))
                                .font(.system(size: 18, weight: .semibold))
                                Spacer()
                        }.frame(width: 250)
                        
                        ZStack {
                            TextField("", text: $name)
                                .frame(width: 250, height: 40)
                                .background(Color.white)
                                .cornerRadius(5)
                            HStack {
                                Spacer()
                                Button(action:
                                {
                                    self.name = ""
                                })
                                {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(Color.backgroundColor)
                                }
                                .padding(.trailing, 8)
                            }.frame(width: 250)
                        }
                    }
                    Button(action: {
                        self.gameStatus.save(name: self.name, color: "default")
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        VStack {
                            Text("Save")
                                .frame(width: 250, height: 40)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color.white)
                        }
                        .background(Color.firstColor)
                        .cornerRadius(5)
                    }.padding(.bottom, 25)
                    Spacer()
                    
                }.navigationBarTitle("", displayMode: .inline)
                .background(NavigationConfigurator { nc in
                    nc.navigationBar.barTintColor = UIColor.backgroundColor
                })
                .navigationBarItems(
                    leading:
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }) { Text("Cancel").foregroundColor(Color.firstColor).font(.system(size: 16, weight: .semibold)) }
                )
                    
            }
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

struct DeckFormView_Previews: PreviewProvider {
    static var previews: some View {
        DeckFormView()
    }
}
