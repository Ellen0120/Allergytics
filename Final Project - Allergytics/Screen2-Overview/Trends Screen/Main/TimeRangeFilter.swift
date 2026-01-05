//
//  TimeRangeFilter.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/30.
//

import Foundation

struct TimeRangeFilter {
    static func filterRecords(_ records: [AllergyRecord], by key: String) -> [AllergyRecord] {
        let calendar = Calendar.current
        let now = Date()
        
        switch key {
        case "today":
            return records.filter{ calendar.isDateInToday($0.dateTime)
            }
            
        case "7d":
            if let date = calendar.date(byAdding: .day, value: -7, to: now) {
                return records.filter {$0.dateTime >= date}
            }
            
        case "30d":
            if let date = calendar.date(byAdding: .day, value: -30, to: now) {
                    return records.filter {$0.dateTime >= date}
            }
            
        case "90d":
            if let date = calendar.date(byAdding: .day, value: -90, to: now) {
                return records.filter {$0.dateTime >= date}
            }
            
        case "6m":
            if let date = calendar.date(byAdding: .month, value: -6, to: now) {
                return records.filter {$0.dateTime >= date}
            }
            
        case "12m":
            if let date = calendar.date(byAdding: .month, value: -12, to: now) {
                return records.filter {$0.dateTime >= date}
            }
        
        case "all":
            fallthrough
            
        default:
            return records
        }
        return records
    }
}
