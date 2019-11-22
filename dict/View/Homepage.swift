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
            VStack {
                Text("Welcome back!")
                NavigationLink(destination: Game()) {
                    Text("Play").font(.title).fontWeight(.bold)
                }
                NavigationLink(destination: Dictionary(), isActive: self.$showingChildView) { EmptyView()
                }
                .frame(width: 0, height: 0)
                .disabled(true)
            }
            .navigationBarItems(
                trailing: Button(action:{ self.showingChildView = true }) {
                    Text("Dictionary")
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
