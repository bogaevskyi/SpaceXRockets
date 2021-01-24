//
//  SceneDelegate.swift
//  SpaceXRockets
//
//  Created by Andrew Bohaevskiy on 23.01.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: ApplicationCoordinator?
    let httpClient = HttpClient(baseURL: URL(string: "https://api.spacexdata.com/v3")!)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        coordinator = ApplicationCoordinator(window: window, networkService: httpClient)
        coordinator?.start()

        self.window = window
    }
}
