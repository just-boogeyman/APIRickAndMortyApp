//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 25.02.2025.
//

import UIKit
import Kingfisher

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
	
	@objc func clearCache() {
		let cache = ImageCache.default
		cache.clearMemoryCache()
		cache.clearDiskCache()
	}
	
	@objc func infoApplication() {
		let infoVC = InfoViewController()
		present(infoVC, animated: true)
	}
}

// MARK: - Setup Views
private extension ListViewController {
	func setup() {
		view.backgroundColor = .darkGray
		title = Constants.title
		setupSearchController()
		setupScopeBar()
	}
	
	func setupSearchController() {
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = Constants.searchPlaceholder
		searchController.searchBar.barTintColor = .white
		searchController.searchBar.tintColor = .systemPurple
		searchController.searchBar.searchBarStyle = .minimal
		
		let buttonTrash = UIBarButtonItem(
			barButtonSystemItem: .trash,
			target: self,
			action: #selector(clearCache)
		)
		let buttonInfo = UIBarButtonItem(
			barButtonSystemItem: .bookmarks,
			target: self,
			action: #selector(infoApplication)
		)

		buttonTrash.tintColor = .systemPurple
		buttonInfo.tintColor = .systemPurple
		
		navigationItem.rightBarButtonItem = buttonTrash
		navigationItem.leftBarButtonItem = buttonInfo
		
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}
	
	func setupScopeBar() {
		let scopeBarAppearance = UISearchBar.appearance()
		scopeBarAppearance.setScopeBarButtonTitleTextAttributes(
			[.foregroundColor: UIColor.gray], for: .normal)
			   
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
			self.searchController.searchBar.selectedScopeButtonIndex = 0
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
		filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		if searchController.isActive {
			searchBar.showsScopeBar = false
			searchBar.selectedScopeButtonIndex = 0
		}
	}
}

// MARK: - UISearchResultsUpdating
extension ListViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		let searchBar = searchController.searchBar
		let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
		if searchController.isActive {
			searchBar.setShowsScope(true, animated: true)
		}
		filterContentForSearchText(searchController.searchBar.text!, scope: scope)
	}
	
	private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
		if isFiltering {
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
