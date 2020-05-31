//
//  OnBoardingView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 31/05/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct OnboardingElement {
    var image: Image
    var title: String
    var description: String
}

struct OnBoardingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var animate0 = false
    @State private var animate = false
    
    let elements = [
        OnboardingElement(image: Image("dictionary_icon"), title: "Create dictionaries", description: "Create decks that will have your flashcards!"),
        OnboardingElement(image: Image("flashcard_icon"), title: "Add flashcards", description: "Flashcards with anything you want to revise - maybe vocabulary!"),
        OnboardingElement(image: Image("game_icon"), title: "Play swipe game", description: "Play game and learn words. Swipe right or left for revision!"),
        
    ]
    
    var body: some View {
        VStack{
            VStack (alignment: .leading) {
                VStack (alignment: .leading) {
                    Text("Welcome to").foregroundColor(Color.black)
                    Text("FlashHero").foregroundColor(Color.blue)
                }
                .font(.system(size: 40, weight: .heavy))
                .padding(.bottom, 35)
                .scaleEffect(animate0 ? 1 : 0.7)
                
                ForEach(0..<self.elements.count) { index in
                    HStack {
                        self.elements[index].image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64, height: 64)
                            .padding(.trailing, 20)

                        VStack (alignment: .leading) {
                            Text(self.elements[index].title).font(.system(size: 20, weight: .bold))
                            Text(self.elements[index].description).font(.system(size: 16, weight: .medium)).foregroundColor(Color.quinaryBackgroundColor)
                        }
                        Spacer()
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .padding(.bottom, 20)
                .opacity(animate ? 1.0 : 0)
            }
            
            Button(action: {
                self.viewRouter.updateView(tabName: .dictionary)
            }) {
                ButtonView(text: "CONTINUE", backgroundColor: Color.blue)
            }
            .padding(.top, 40)
            .opacity(animate ? 1.0 : 0)
        }
        .offset(y: animate ? 0 : 220)
        .animation(.default)
        .onAppear {
            withAnimation(.easeOut(duration: 5)) {
                self.animate0.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.animate.toggle()
                }
            }
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
