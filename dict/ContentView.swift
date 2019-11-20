//
//  ContentView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var name: String = "Tim"
    
    
    var body: some View {
        Form {
            Text("Hello, World!")
            Text("Hello, World!")
            TextField(" Enter some text", text: $name)
        }.navigationBarTitle("Add word")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
