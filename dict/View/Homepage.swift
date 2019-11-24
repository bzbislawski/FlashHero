//
//  Homepage.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct Homepage: View {
    @State private var showingChildView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack() {
                    Text("Welcome back!").padding(.top, 80)
                    Spacer()
                }
                
                NavigationLink(destination: Game()) {
                    Text("Play")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(width:120, height: 65)
                        .background(Color.blue)
                        .cornerRadius(3100)
                        .shadow(radius: 20, x: 0, y: 20)
                    
                }
                
                NavigationLink(destination: Dictionary(), isActive: self.$showingChildView) { EmptyView()
                }
                .frame(width: 0, height: 0)
                .disabled(true)
            }
            .navigationBarItems(
                trailing: Button(action:{ self.showingChildView = true }) {
                    Text("Dictionary")
                        .frame(minHeight: 44)
                        .font(.system(size: 20))
                }
            )
        }
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
