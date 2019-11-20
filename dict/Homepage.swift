//
//  Homepage.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct Homepage: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome back!")
                NavigationLink(destination: Game()) {
                    Text("Play")
                }
            }.navigationBarItems(trailing:
                HStack {
                    NavigationLink(destination: ContentView()) {
                        Image(systemName: "plus.circle.fill")
                    }
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
