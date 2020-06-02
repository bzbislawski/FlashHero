//
//  CardSwipeTime.swift
//  dict
//
//  Created by Bartosz Zbislawski on 31/05/2020.
//  Copyright © 2020 Bartosz Zbislawski. All rights reserved.
//

import Foundation

class Timer: ObservableObject {
    @Published var date: Date? = nil
    var countingStarted = false
    
    func start() {
        if countingStarted == false {
            self.date = Date()
            self.countingStarted = true
        }
    }
    
    func stop() -> Double {
        var interval: TimeInterval = (Date()).timeIntervalSince1970
        if self.date != nil {
            interval = (Date()).timeIntervalSince(self.date!)
        }
        countingStarted = false
        return interval
    }
}
