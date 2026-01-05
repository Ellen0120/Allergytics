//
//  Screen3_VC+Saving.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/12/3.
//

import Foundation
import UIKit
import FirebaseAuth

extension Screen3_VC {
    // MARK:  Save Allergy Record to Firebase
    func saveAllergyRecordToFirebase(data: [String: Any]) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        AllergyRecordManager.shared.saveRecord(
            userID: uid,
            recordID: receivedRecord?.id,
            data: data,
            isEditing: statusEditing
        ) { error in
            if let error = error {
                print("Error saving document: \(error)")
            } else {
                print("Document saved successfully!")
            }
        }
        
    }
}
