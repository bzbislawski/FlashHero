//
//  SettingsView.swift
//  dict
//
//  Created by Bartosz Zbislawski on 06/12/2019.
//  Copyright © 2019 Bartosz Zbislawski. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State private var showGreeting = true
    @State private var dictionariesOrderOption = "default"
    @State private var cardsOrderOption = "default"

    
    var dictionariesOrder: Array<String> {
        return ["Default", "Alphabetical", "Random"]
    }
    
    var cardsOrder: Array<String> {
        return ["Default", "Alphabetical", "Random"]
    }
       

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notifications settings")) {
                    VStack {
                        Toggle(isOn: $showGreeting) {
                            Text("Show welcome message").font(.system(size: 15))
                        }
                    }
                }
                
                Section(header: Text("Game settings")) {
                    VStack {
                        Picker(
                            selection: $dictionariesOrderOption,
                            label: Text("Dictionary order").font(.system(size: 15))
                        ) {
                            ForEach(self.dictionariesOrder, id: \.self) {option in
                                Text(option).font(.system(size: 15))
                            }
                        }
                        Divider()
                        Picker(
                            selection: $cardsOrderOption,
                            label: Text("Cards order").font(.system(size: 15))
                        ) {
                            ForEach(self.cardsOrder, id: \.self) {option in
                                Text(option).font(.system(size: 15))
                            }
                        }
                    }
                }
            }.navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
