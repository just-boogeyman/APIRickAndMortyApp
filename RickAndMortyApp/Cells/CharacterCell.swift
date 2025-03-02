//
//  CharacterCell.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 28.02.2025.
//

import UIKit

final class CharacterCell: UITableViewCell {
	
	private let customView = CustomViewCell()
	
	// MARK: - Init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with item: Results) {
		customView.configure(item)
	}
}

private extension CharacterCell {
	func setup() {
		backgroundColor = .gray
		addSubview(customView)
		layout()
	}
}

private extension CharacterCell {
	func layout() {
		customView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			customView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			customView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			customView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			customView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
		])
	}
}
