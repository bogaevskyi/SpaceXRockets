//
//  SceneDelegate.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 23.01.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}
