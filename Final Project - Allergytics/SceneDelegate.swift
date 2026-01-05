//
//  SceneDelegate.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/10/22.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var handleAuth: AuthStateDidChangeListenerHandle?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
           
        // MARK: Add Firebase Auth Listener (Sign in/ Sign out/ Register)
        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
                if let user = user {
                    // MARK: Sign In
                    print("User is signed in: \(user.email ?? "No email")")
                    let tabBar = TabBar_VC()
                    let navigationController = UINavigationController(
                                    rootViewController: tabBar
                            )
                    self.window?.rootViewController = navigationController
                    self.window?.makeKeyAndVisible()
                } else {
                    // MARK: Sign Out
                    print("No user is signed in.")
                    let signIn = Screen1_signInVC()
                    let navigationController = UINavigationController(
                        rootViewController: signIn
                    )
                    self.window?.rootViewController = navigationController
                    self.window?.makeKeyAndVisible()
                    
                    
                }
            
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

