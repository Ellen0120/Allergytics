//
//  Data Process.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/25.
//

import Foundation

struct DataProcessor {
    // Time of Day (Morning/ Afternoon/ Evening/ Night)
    static func processTimeofDay(_ records: [AllergyRecord]) -> [String: Int] {
        
        var result: [String: Int] = [
            "Morning": 0,
            "Afternoon": 0,
            "Evening": 0,
            "Night": 0
        ]
        
        let calendar = Calendar.current
        
        for record in records {
            let hour = calendar.component(.hour, from: record.dateTime)
            
            switch hour {
            case 6..<12:
                    result["Morning"]! += 1
            case 12..<18:
                result["Afternoon"]! += 1
            case 18..<22:
                result["Evening"]! += 1
            default:
                result["Night"]! += 1
            }
        }
        
        return result
    }
    
    // Daily Trend
    static func processDailyTrend(_ records: [AllergyRecord]) -> [(date: String, count: Int)] {
        
        var dailyDist: [String: Int] = [:]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        for record in records {
            let dateString = formatter.string(from: record.dateTime)
            dailyDist[dateString, default: 0] += 1
        }
        
        // Sort by date
        let sorted = dailyDist.sorted { $0.key < $1.key }
        return sorted.map {($0.key, $0.value)}
        
    }
    
    // Trigger
    static func processTrigger(_ records: [AllergyRecord]) -> [String: Int] {
        var frequency: [String: Int] = [:]
        
        for record in records {
            for trigger in record.triggers {
                frequency[trigger, default: 0] += 1
            }
        }
        // print(frequency)
        return frequency
        
    }
    
    // Symptom
    static func processSymptom(_ records: [AllergyRecord]) -> [String: Int] {
        var frequency: [String: Int] = [:]
        
        for record in records {
            for symptom in record.symptoms {
                frequency[symptom, default: 0] += 1
            }
        }
      //  print(frequency)
        return frequency
    }
    
    // Severity
    static func processSeverity(_ records: [AllergyRecord]) -> [String: Int] {
        var frequency: [String: Int] = [:]
        
        for record in records {
            frequency[record.severity, default: 0] += 1
        }
        print(frequency)
        return frequency
    }
}
