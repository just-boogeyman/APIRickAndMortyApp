//
//  CustomViewCell.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 28.02.2025.
//

import UIKit

final class CustomViewCell: UIView {
	
	// MARK: - Private Property
	private let nameLabel = UILabel()
	private let imageView = UIImageView()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	
	@available (*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(_ item: Results) {
		nameLabel.text = item.name
//		imageView.image = UIImage(named: item.image)
	}
}

private extension CustomViewCell {
	func setupView() {
		backgroundColor = .lightGray
		layer.cornerRadius = 12
		addView()
	}
	
	func addView() {
		[nameLabel, imageView].forEach {
			addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
	}
	
	func setupImage() {
		
	}
	
	func setupLabel() {
		nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
	}
}

private extension CustomViewCell {
	func layout() {
		NSLayoutConstraint.activate([
			nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20)
		])
	}
}
