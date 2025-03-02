//
//  CustomListView.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 28.02.2025.
//

import UIKit

final class CustomListView: UIView {
	// MARK: - Private Property
	private var tableView: UITableView!
	private let cellIdentifier = "cellList"
	private let networkManager = NetworkManager.shared
	
	private var items: [Results] = []
	var action: ((Results) -> ())?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		fetchCharacters()
		setupView()
	}
	
	
	@available (*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public Func
	func configure(_ items: [Results]) {
		self.items = items
	}
}

// MARK: - Setup View
private extension CustomListView {
	func setupView() {
		setupTableView()
		addSubview(tableView)
		layout()
	}
	
	func setupTableView() {
		tableView = UITableView(frame: .zero, style: .plain)
		tableView.register(CharacterCell.self, forCellReuseIdentifier: cellIdentifier)
		tableView.rowHeight = 120
		tableView.delegate = self
		tableView.dataSource = self
	}
}

// MARK: - Private Methods
private extension CustomListView {
	func fetchCharacters() {
		networkManager.fetch(Character.self, url: RickAndMortyAPI.characters.rawValue) { [weak self] result in
			switch result {
			case .success(let items):
				self?.items = items.results
				DispatchQueue.main.async {
					self?.tableView.reloadData()
				}
			case .failure(let error):
				print(error)
			}
		}
	}
}

// MARK: - Layout
private extension CustomListView {
	func layout() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

// MARK: - UITableViewDataSource
extension CustomListView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: cellIdentifier,
			for: indexPath
		) as? CharacterCell else { return UITableViewCell() }
		
		let item = items[indexPath.row]
		cell.configure(with: item)
		
		return cell
	}
}

// MARK: - UITableViewDelegate
extension CustomListView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		action?(items[indexPath.row])
	}
}
