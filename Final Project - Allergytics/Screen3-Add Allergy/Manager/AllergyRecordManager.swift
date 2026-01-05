//
//  AllergyRecordManager.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/27.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AllergyRecordManager {
    static let shared = AllergyRecordManager()
    private let db = Firestore.firestore()
    
    private init() {}
    
    func saveRecord(
        userID: String,
        recordID: String?,
        data: [String: Any],
        isEditing: Bool,
        completion: ((Error?) -> Void)? = nil
    ) {
        let userRef = db.collection("User").document(userID).collection("AllergyRecords")
        if isEditing, let recordID = recordID {
            userRef.document(recordID).setData(data) { error in
                completion?(error)
            }
        } else {
            userRef.addDocument(data: data) { error in
                completion?(error)
            }
        }
        
    }
}

/*
 // MARK:  Save Allergy Record to Firebase
 func saveAllergyRecordToFirebase(data: [String: Any]) {
     guard let currentUser = Auth.auth().currentUser else { return }
     
     if statusEditing {
         if let id = receivedRecord?.id {
             db.collection("User")
                 .document(currentUser.uid)
                 .collection("AllergyRecords")
                 .document(id)
                 .setData(data) { error in
                     if let error = error {
                         print("Error saving edited document: \(error)")
                     } else {
                         print("Document edited successfully!")
                         print("Edited data: \(data)")
                     }
                 }
         } else {
             print()
         }
     } else {
         db.collection("User")
             .document(currentUser.uid)
             .collection("AllergyRecords")
             .addDocument(data: data) { error in
             if let error = error {
                 print("Error adding document: \(error)")
             } else {
                 print("Document added successfully!")
                 print("Saved data: \(data)")
             }
         }
     }
 }
 */
