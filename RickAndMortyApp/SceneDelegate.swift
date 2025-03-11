//
//  SceneDelegate.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 25.02.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let windowScene = scene as? UIWindowScene else { return }
		window = UIWindow(windowScene: windowScene)
		let navVC = getNavigationController()
		window?.rootViewController = navVC
		window?.makeKeyAndVisible()
	}
}

func getNavigationController() -> UINavigationController {
	let vc = ListViewController()
	let navController = UINavigationController(rootViewController: vc)
	navController.navigationBar.prefersLargeTitles = true
	
	let appearance = UINavigationBarAppearance()
	appearance.configureWithOpaqueBackground()
	appearance.backgroundColor = .darkGray
		
	appearance.titleTextAttributes = [
		.foregroundColor: UIColor(resource: .background),
		.font: UIFont.systemFont(ofSize: 18, weight: .bold)
	]
	
	appearance.largeTitleTextAttributes = [
		.foregroundColor: UIColor(resource: .background),
		.font: UIFont.systemFont(ofSize: 34, weight: .bold)
	]
	
	navController.navigationBar.standardAppearance = appearance
	navController.navigationBar.scrollEdgeAppearance = appearance
	
	return navController
}
