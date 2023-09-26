//
//  SceneDelegate.swift
//  AppStore_Clone
//
//  Created by LS-MAC-00211 on 2023/09/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    let roootVC = ViewController()
    window?.rootViewController = UINavigationController(rootViewController: roootVC)
    window?.makeKeyAndVisible()
  }
}

