//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 25.02.2025.
//

import UIKit

final class ListViewController: UIViewController {
	
	private let networkManager = NetworkManager.shared
	
	// MARK: - Private Properties
	private var filteredCharacters: [Results] = []
	private var items: [Results] = []
	private var searchBarIsEmpty: Bool {
		guard let text = searchController.searchBar.text else { return false }
		return text.isEmpty
	}
	private var isFiltering: Bool {
		return searchController.isActive && !searchBarIsEmpty
	}
	
	private let customView = CustomListView()
	private let searchController = UISearchController(searchResultsController: nil)

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		pushDetailVC()
	}
	
	override func loadView() {
		fetchCharacters()
		view = customView
	}
}

// MARK: - Setup Views
private extension ListViewController {
	func setup() {
		view.backgroundColor = .darkGray
		title = Constants.title
		setupSearchController()
	}
	
	func setupSearchController() {
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = Constants.searchPlaceholder
		searchController.searchBar.barTintColor = .white
		searchController.searchBar.tintColor = .purple
		searchController.searchBar.searchBarStyle = .minimal
		navigationItem.searchController = searchController
		definesPresentationContext = true
		
		if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
			textField.font = UIFont.boldSystemFont(ofSize: 17)
			textField.textColor = .white
			textField.backgroundColor = .lightGray
		}
	}
}

// MARK: - Private Method
private extension ListViewController {
	func pushDetailVC() {
		customView.action = { [weak self] item in
			let vc = DetailViewController()
			vc.title = item.name
			vc.configure(with: item)
			self?.navigationController?.pushViewController(vc, animated: true)
		}
	}
	
	func fetchCharacters() {
		networkManager.fetch(Character.self, url: RickAndMortyAPI.characters.rawValue) { [weak self] result in
			switch result {
			case .success(let items):
				self?.items = items.results
				self?.customView.configure(with: items.results)
			case .failure(let error):
				print(error)
			}
		}
	}
}

// MARK: - UISearchResultsUpdating
extension ListViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		filterContentForSearchText(searchController.searchBar.text!)
	}
	
	private func filterContentForSearchText(_ searchText: String) {
		if isFiltering {
			filteredCharacters = items.filter({ (item: Results) -> Bool in
				return item.name.lowercased().contains(searchText.lowercased())
			})
			customView.configure(with: filteredCharacters)
		} else {
			customView.configure(with: items)
		}
	}
}

// MARK: - Enum Constants
extension ListViewController {
	private enum Constants {
		static let title = "Rick and Morty"
		static let searchPlaceholder = "Search"
	}
}
