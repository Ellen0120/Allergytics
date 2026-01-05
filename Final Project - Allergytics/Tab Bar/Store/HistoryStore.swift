//
//  HistoryStore.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 11/20/25.
//

import Foundation

class HistoryStore {
    static let shared = HistoryStore()
    private init() {}
    
    var history = [AllergyRecord]()
}
