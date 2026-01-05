//
//  User Info.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/9.
//

import Foundation
import FirebaseFirestore

struct UserInfo: Codable{
    @DocumentID var id: String?
    var name: String
    var email: String
    var phone: String
    var photoURL: String?
    
    init(name: String, email: String, phone: String, photoURL: String?) {
        self.name = name
        self.email = email
        self.phone = phone
        self.photoURL = photoURL
    }
}
