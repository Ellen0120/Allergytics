//
//  HistoryInfo.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes on 11/11/25.
//

import Foundation

struct HistoryInfo {
    var trigger: String
    var timestamp: Date
    
    init( trigger: String, timestamp: Date) {
        self.trigger = trigger
        self.timestamp = timestamp
    }
}

