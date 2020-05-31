//
//  ViewRouter.swift
//  dict
//
//  Created by Bartosz Zbislawski on 10/03/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import Foundation
import SwiftUI

enum Homepage {
    case dictionary, game, onboarding
}

class ViewRouter: ObservableObject {
    
    @Published var currentView: Homepage = .dictionary
    
    func updateView(tabName: Homepage) {
        self.currentView = tabName
    }
}
