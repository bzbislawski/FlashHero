//
//  ContentView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 20/11/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var word: String = ""
    @State private var translation: String = ""
    
    
    var body: some View {
        Form {
            Section(header: Text("Word")) {
                TextField(" Enter some word here...", text: $word)
            }
            Section(header: Text("Translation")) {
                TextField(" Enter the translation here...", text: $translation)
            }
        }
        .navigationBarTitle("Add word")
        .navigationBarItems(trailing:
            HStack {
                Text("Save")
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
