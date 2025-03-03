//
//  CustomListView.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 28.02.2025.
//

import UIKit

final class CustomListView: UITableView {
	
	// MARK: - Private property
	private let cellIdentifier = "cellList"
	private var items: [Results] = []
	
	// MARK: - Public property
	var action: ((Results) -> ())?
	
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: .plain)
		setupView()
	}
	
	@available (*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public func
	func configure(with items: [Results]) {
		self.items = items
		self.reloadData()
	}
}

// MARK: - Setup view
private extension CustomListView {
	func setupView() {
		setupTableView()
		layout()
	}
	
	func setupTableView() {
		backgroundColor = .darkGray
		register(CharacterCell.self, forCellReuseIdentifier: cellIdentifier)
		rowHeight = 115
		separatorStyle = .none
		delegate = self
		dataSource = self
	}
}

// MARK: - Private methods
private extension CustomListView {

}

// MARK: - Layout
private extension CustomListView {
	func layout() {
		NSLayoutConstraint.activate([
			leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
			topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
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
		deselectRow(at: indexPath, animated: true)
		action?(items[indexPath.row])
	}
}
