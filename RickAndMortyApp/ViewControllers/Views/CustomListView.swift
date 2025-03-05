//
//  CustomListView.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 28.02.2025.
//

import UIKit

final class CustomListView: UITableView {
	
	// MARK: - Public Property
	var action: ((Character) -> ())?
	var actionRefresh: (() -> ())?

	
	// MARK: - Private Property
	private let cellIdentifier = "cellList"
	private var items: [Character] = []
	
	// MARK: - Initializers
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: .plain)
		setupView()
	}
	
	@available (*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public Method
	func configure(with items: [Character]) {
		self.items = items
		self.reloadData()
		if refreshControl != nil {
			refreshControl?.endRefreshing()
		}
	}
}

// MARK: - Setup views
private extension CustomListView {
	func setupView() {
		setupTableView()
		setupRefreshControl()
		
	}
	
	func setupTableView() {
		backgroundColor = .darkGray
		register(CharacterCell.self, forCellReuseIdentifier: cellIdentifier)
		rowHeight = 115
		separatorStyle = .none
		delegate = self
		dataSource = self
	}
	
	func setupRefreshControl() {
		refreshControl = UIRefreshControl()
		refreshControl?.tintColor = .systemPurple
		let attribures: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.systemPurple,
			.font: UIFont.systemFont(ofSize: 16)
		]
		let attributedTitle = NSAttributedString(string: "Обновление...", attributes: attribures)
		refreshControl?.attributedTitle = attributedTitle
		refreshControl?.addTarget(self, action: #selector(chengeRefresh), for: .valueChanged)
	}
}

// MARK: - Private methods
private extension CustomListView {
	@objc private func chengeRefresh() {
		actionRefresh?()
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
		deselectRow(at: indexPath, animated: true)
		action?(items[indexPath.row])
	}
}
