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
	private var filteredCharacters: [Character] = []
	private var items: [Character] = []
	private var searchBarIsEmpty: Bool {
		guard let text = searchController.searchBar.text else { return false }
		return text.isEmpty
	}
	private var isFiltering: Bool {
		let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
		return searchController.isActive && (!searchBarIsEmpty || searchBarScopeIsFiltering)
	}
	
	private let customView = CustomListView()
	private let searchController = UISearchController(searchResultsController: nil)

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		pushDetailVC()
		pressedRefresh()
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
		// Setup the Search Controller
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = Constants.searchPlaceholder
		searchController.searchBar.barTintColor = .white
		searchController.searchBar.tintColor = .purple
		searchController.searchBar.searchBarStyle = .minimal
		navigationItem.searchController = searchController
		definesPresentationContext = true
		
		// Setup the Scope Bar
		searchController.searchBar.scopeButtonTitles = Constants.allScope
		searchController.searchBar.delegate = self
		
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
	
	func pressedRefresh() {
		customView.actionRefresh = {
			self.fetchCharacters()
		}
	}
	
	func fetchCharacters() {
		networkManager.fetch(
			Characters.self,
			url: "https://rickandmortyapi.com/api/character?page=\(Int.random(in: 1...42))"
		) { [weak self] result in
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

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		print("5")
		filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
	}
}

// MARK: - UISearchResultsUpdating
extension ListViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		let searchBar = searchController.searchBar
		let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
		print("1")
		filterContentForSearchText(searchController.searchBar.text!, scope: scope)
	}
	
	private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
		if isFiltering {
			print("2")
			filteredCharacters = items.filter({ (item: Character) -> Bool in
				let doesCategoryMatch = (scope == "All") || (item.status == scope)
				if searchBarIsEmpty {
					return doesCategoryMatch
				} else {
					return doesCategoryMatch && item.name.lowercased().contains(searchText.lowercased())
				}
			})
			customView.configure(with: filteredCharacters)
		} else {
			print("3")

			customView.configure(with: items)
		}
	}
}

// MARK: - Enum Constants
extension ListViewController {
	private enum Constants {
		static let title = "Rick and Morty"
		static let searchPlaceholder = "Search"
		static let allScope = ["All", "Alive", "Dead", "unknown"]
	}
}
