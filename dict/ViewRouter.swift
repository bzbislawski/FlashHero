//
//  ViewRouter.swift
//  dict
//
//  Created by Bartosz Zbislawski on 10/03/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import Foundation
import SwiftUI

enum Homepapge {
    case dictionary, game, settings
}

class ViewRouter: ObservableObject {
    
    @Published var currentView: Homepapge = .dictionary
}
