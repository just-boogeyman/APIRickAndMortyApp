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
	
	private var items: [Results] = []
	
	override init(frame: CGRect) {
		super.init(frame: frame)
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
//		tableView.delegate = self
		tableView.dataSource = self
	}
}

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

extension CustomListView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: cellIdentifier,
			for: indexPath
		) as? CharacterCell else { return UITableViewCell() }
		
		return cell
	}
}
