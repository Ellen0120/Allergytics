//
//  RecordManager.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 11/20/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

enum UploadError: Error {
    case jpegConversionFailed
    case downloadURLFailed
    case userActivity
}

enum AccountError: Error {
    case noCurrentUser
}

class AccountManager {
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    // MARK: - Delete an account
    func deleteAccount(completion: @escaping (Result<User, Error>) -> Void) {
        // MARK: Check currently signed-in user
        guard let user = Auth.auth().currentUser else {
            print("No user signed in.")
            completion(.failure(AccountError.noCurrentUser))
            return
        }

        print("Deleting user...")
        let uid = user.uid
        let documentRef = self.db.collection("User").document(uid)

        // MARK: Check the user document
        documentRef.getDocument { snapshot, error in
            if let error = error {
                print("Error occurred while getting document from Firestore: \(error)")
                return
            }
            // MARK: If storage has user's profile photo, delete it
            if let data = snapshot?.data(),
               let photoURL = data["photoURL"] as? String {
                self.deleteProfilePhotoFromStorage(from: photoURL) { result in
                    switch result {
                    case true:
                        print("Deleted an old photo: \(photoURL)")
                    case false:
                        print("Failed to delete an old photo")
                    }
                }
            }

            // MARK: Delete user's Firestore document
            documentRef.delete { error in
                if let error = error {
                    print("Error occurred while deleting Firestore document: \(error)")
                    completion(.failure(error))
                    return
                } else {
                    AccountStore.shared.account = nil
                }

                // MARK: Delete the user from FireAuth
                user.delete { error in
                    if let error = error {
                        print("Error in deleting user: \(error)")
                        completion(.failure(error))
                    } else {
                        print("User deleted successfully!")
                        completion(.success(user))
                    }
                }
            }
        }
    }

    
    // MARK: - Edit an account
    func editAccount(
        account: UserInfo,
        oldPhotoURL: String?,
        completion: @escaping (Result<User, Error>) -> Void
    ){
        if let user = Auth.auth().currentUser {
            let urlString = account.photoURL
            db.collection("User")
                .document(user.uid)
                .setData([
                    "name": account.name,
                    "email": account.email,
                    "phone": account.phone,
                    "photoURL": urlString
                ])
            if let url = oldPhotoURL {
                self.deleteProfilePhotoFromStorage(from: url) { result in
                    switch result {
                    case true:
                        print("Deleted an old photo: \(urlString ?? "")")
                    case false:
                        print("Failed to delete an old photo")
                    }
                }
            }
            completion(.success(user))
            print("Edited account: \(account)")
        } else {
            completion(.failure(UploadError.userActivity))
            print("No user signed in.")
        }
    }
    
    // MARK: - Create an account
    func createAccount(
        name: String,
        email: String,
        password: String,
        phone: String,
        photo: UIImage?,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // Handle Error
                print("Error in creating an account: \(error)")
                completion(.failure(error))
                return
            } else if let userActivity = authResult?.user {
                Task {
                    var url = nil as URL?
                    if let profilePhoto = photo {
                        url = await self.uploadProfilePhotoToStorage(image: profilePhoto)
                    }
                    // Add to user database
                    self.addUserToFireStore(name: name, email: email, phone: phone, uid: userActivity.uid, photoURL: url) {result in
                        print("User Created: \(userActivity)")
                        completion(.success(userActivity))
                    }
                }
            } else {
                completion(.failure(UploadError.userActivity))
            }
        }
    }
    
    // MARK: - Save User Info in Firebase Storage
        // User -> User.uid -> name/email/phone
    func addUserToFireStore(
        name: String,
        email: String,
        phone: String,
        uid: String,
        photoURL: URL?,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        // User collection
        let collectionUsers = db.collection("User")
        let urlString = photoURL?.absoluteString
        collectionUsers.document(uid).setData([
            "name": name,
            "email": email,
            "phone": phone,
            "photoURL": urlString
        ]) { error in
            if let error = error {
                completion(.failure(error))
                print("Error adding document: \(error)")
            } else {
                completion(.success(uid))
                print("Document added successfully")
            }
        }
        
        print("Save \(name) info to Firestore Successfully")
    }
    
    // MARK: - Upload the profile photo
    func uploadProfilePhotoToStorage(image: UIImage) async -> URL? {
        //Upload the profile photo if there is any...
        if let jpegData = image.jpegData(compressionQuality: 80){
            let storageRef = storage.reference()
            let imagesRepo = storageRef.child("profileImages")
            let imageRef = imagesRepo.child("\(NSUUID().uuidString).jpg")
            
            do {
                // Wait for putData with async/await
                _ = try await withCheckedThrowingContinuation {
                    (continuation: CheckedContinuation<StorageMetadata?, Error>) in

                    imageRef.putData(jpegData, metadata: nil) { metadata, error in
                        if let error = error {
                            continuation.resume(throwing: error)
                        } else {
                            continuation.resume(returning: metadata)
                        }
                    }
                }
            } catch {
                print("Was not able to upload the photo to Storage: \(error)")
            }
            
            do {
                // Wait for downloadURL with async/await
                let url: URL = try await withCheckedThrowingContinuation { continuation in
                    imageRef.downloadURL { url, error in
                        if let error = error {
                            continuation.resume(throwing: error)
                        } else if let url = url {
                            continuation.resume(returning: url)
                        } else {
                            continuation.resume(throwing: UploadError.downloadURLFailed)
                        }
                    }
                }
                return url
            } catch {
                print("Was not able to download the photo from Storage: \(error)")
                return nil
            }
        }
        
        return nil
    }
    
    func deleteProfilePhotoFromStorage(
        from url: String,
        completion: @escaping (Bool) -> Void
    ) {
        let imageRef = storage.reference(forURL: url)

        imageRef.delete { error in
            if let error = error {
                print("Was not able to delete the photo properly: \(error)")
                completion(false)
            } else {
                print("Successfully deleted a photo: \(url)")
                completion(true)
            }
        }
    }
}
