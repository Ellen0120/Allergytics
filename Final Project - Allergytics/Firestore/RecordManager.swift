//
//  RecordManager.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 11/20/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RecordManager {
    let db = Firestore.firestore()
    
    func deleteRecord(record: AllergyRecord? = nil) {
        if let user = Auth.auth().currentUser {
            if let rec = record,
               let id = rec.id {
                print("Deleting record...")
                self.db.collection("User").document(user.uid)
                    .collection("AllergyRecords")
                    .document(id)
                    .delete() { error in
                        if let error = error {
                            print("Error deleting record: \(error)")
                        } else {
                            print("Record deleted successfully")
                        }
                    }
            } else {
                print("No record to delete.")
            }
        } else {
            print("No user signed in.")
        }
    }
}
