//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 25.02.2025.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .cyan
		view.backgroundColor = .white
		fetchCharacters()
	}
}

private extension ViewController {
	func fetchCharacters() {
		guard let url = URL(string: RickAndMortyAPI.characters.rawValue) else { return }
		
		URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data else {
				print(error?.localizedDescription ?? "No Error description")
				return
			}
			
			do {
				let characters = try JSONDecoder().decode(Characters.self, from: data)
				print(characters)
			} catch let error {
				print(error.localizedDescription)
			}
			
		}.resume()
	}
}

