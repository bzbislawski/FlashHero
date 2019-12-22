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
    @State private var dictionariesOrderOption = "Default"
    @State private var cardsOrderOption = "Default"

    
    var dictionariesOrder: Array<String> {
        return ["Default", "Alphabetical", "Random"]
    }
    
    var cardsOrder: Array<String> {
        return ["Default", "Alphabetical", "Random"]
    }
    
    func settingItem(label: String) -> some View {
        return Text(label)
            .font(.system(size: 18))
            .frame(height: 25)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pronunciation"), footer: Text("Flipping a card will automatically play pronunciation.")) {
                    VStack {
                        Toggle(isOn: $showGreeting) {
                            Text("Play pronunciation").font(.system(size: 18))
                        }
                    }
                }
                
                Section() {
                    Picker(
                        selection: $dictionariesOrderOption,
                        label: self.settingItem(label: "Dictionary order")
                    ) {
                        ForEach(self.dictionariesOrder, id: \.self) {option in
                            Text(option).font(.system(size: 18))
                        }
                    }
                    
                    Picker(
                        selection: $cardsOrderOption,
                        label: self.settingItem(label: "Cards order")
                    ) {
                        ForEach(self.cardsOrder, id: \.self) {option in
                            Text(option).font(.system(size: 18))
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
