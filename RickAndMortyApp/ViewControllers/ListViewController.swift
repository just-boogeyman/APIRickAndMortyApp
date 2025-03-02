//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 25.02.2025.
//

import UIKit

final class ListViewController: UIViewController {
	
	// MARK: - Private Properties
	private let customView = CustomListView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .gray
	}
	
	override func loadView() {
		view = customView
	}
}

