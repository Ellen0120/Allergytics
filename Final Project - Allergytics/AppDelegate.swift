//
//  AppDelegate.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/10/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // --- Declare varibles --- //
    var historylist = [AllergyRecord]()                // To store the History information we have in Firebase and show on table
    
    // --- Notification center -- //
    let notificationCenter = NotificationCenter.default
    
    // --- Firebase --- //
    var db: Firestore!
    var handleAuth: AuthStateDidChangeListenerHandle?
    var historyListener: ListenerRegistration?
    var accountListener: ListenerRegistration?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        db = Firestore.firestore()
        
        // --- Retrieve history data from FirebaseStorage --- //
        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                print("No user is signed in.")
            } else {
                self.historyListener?.remove()
                self.historyListener = nil
                self.historyListener = self.db.collection("User").document(user!.uid)
                    .collection("AllergyRecords")
                    .addSnapshotListener(includeMetadataChanges: false, listener: { querySnapshot, erorr in
                        print("Snapshot listener called")
                        HistoryStore.shared.history.removeAll()
                        if let documents = querySnapshot?.documents {
                            self.historylist.removeAll()
                            for document in documents {
                                do {
                                    let data = try document.data(as: AllergyRecord.self)
                                    // print(data)
                                    self.historylist.append(data)
                                    self.historylist.sort(by: { $0.dateTime > $1.dateTime })
                                    HistoryStore.shared.history = self.historylist

                                } catch {
                                    print(error)
                                }
                            }
                        }
                        self.notificationCenter.post(name: .recordReloaded, object: nil)
                        
                })

            }
            
        }
        
        // --- Retrieve account data from FirebaseStorage --- //
        handleAuth = Auth.auth().addStateDidChangeListener({ auth, user in
            if user == nil {
                // User is not signed in
                print("No user signed in.")
            } else {
                self.accountListener?.remove()
                self.accountListener = nil
                AccountStore.shared.account = nil
                self.accountListener = self.db.collection("User")
                    .addSnapshotListener(includeMetadataChanges: false, listener: { querySnapShot, error in
                        if let documents = querySnapShot?.documents {
                            for document in documents {
                                do{
                                    let account  = try document.data(as: UserInfo.self)
                                    // If the id matches with the current user
                                    if account.id == user!.uid {
                                        // Store account information and update labels
                                        AccountStore.shared.account = account
                                        
                                        // Send notification that the account information was fetched
                                        self.notificationCenter.post(
                                            name: .accountReloaded,
                                            object: nil
                                        )
                                        
                                        if let stringURL = account.photoURL {
                                            if let url = URL(string: stringURL) {
                                                DispatchQueue.global().async { [weak self] in
                                                    if let data = try? Data(contentsOf: url) {
                                                        if let image = UIImage(data: data) {
                                                            DispatchQueue.main.async {
                                                                AccountStore.shared.photo = image
                                                                // Send additional notification when the profile photo is fetched
                                                                self?.notificationCenter.post(
                                                                    name: .accountReloaded,
                                                                    object: nil
                                                                )
                                                            }
                                                        }
                                                    }
                                                }
                                            } else {
                                                print("Was not able to convert the URL string to URL.")
                                            }
                                        } else {
                                            print("Profile image is not set.")
                                        }
                                    }
                                }catch{
                                    print(error)
                                }
                            }
                        } else {
                            print("No document was found in the collection.")
                        }
                    })
            }
        })
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

