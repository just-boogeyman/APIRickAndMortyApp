//
//  DetailViewController.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 02.03.2025.
//

import UIKit

final class DetailViewController: UIViewController {
	
	private let customView = CustomDetailView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func loadView() {
		view = customView
	}
	
	func configure(with item: Results) {
		customView.configure(with: item)
	}
}
