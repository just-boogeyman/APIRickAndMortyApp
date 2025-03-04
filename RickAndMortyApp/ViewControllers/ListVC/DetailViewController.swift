//
//  DetailViewController.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 02.03.2025.
//

import UIKit

final class DetailViewController: UIViewController {
	
	// MARK: - Private Properties
	private let customView = CustomDetailView()
	
	// MARK: - Initializers
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func loadView() {
		view = customView
	}
	
	// MARK: - Configure
	func configure(with item: Character) {
		customView.configure(with: item)
	}
}
