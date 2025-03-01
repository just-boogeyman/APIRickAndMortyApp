//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 25.02.2025.
//

import UIKit

class ListViewController: UIViewController {
	
	// MARK: - Private Properties
	private let customView = CustomListView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .gray
		fetchCharacters()
	}
	
	override func loadView() {
		view = customView
	}
}

private extension ListViewController {
	func fetchCharacters() {
		guard let url = URL(string: RickAndMortyAPI.characters.rawValue) else { return }
		
		URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data else {
				print(error?.localizedDescription ?? "No Error description")
				return
			}
			
			do {
				let characters = try JSONDecoder().decode(Character.self, from: data)
				print(characters.results[0].name)
			} catch let error {
				print(error.localizedDescription)
			}
			
		}.resume()
	}
}

