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
		pushDetailVC()
	}
	
	override func loadView() {
		view = customView
	}
}

// MARK: - Private Metod
private extension ListViewController {
	func pushDetailVC() {
		customView.action = { [weak self] item in
			let vc = DetailViewController()
			vc.configure(with: item)
			self?.navigationController?.pushViewController(vc, animated: true)
		}
	}
}

