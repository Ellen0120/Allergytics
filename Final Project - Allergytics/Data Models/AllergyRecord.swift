//
//  Allergy.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/9.
//

import Foundation
import FirebaseFirestore

struct AllergyRecord: Codable {
    @DocumentID var id: String?
    var dateTime: Date
    var triggers: [String]
    var symptoms: [String]
    var severity: String
    var location: LocationResult?
    var additionalNotes: String?
}
