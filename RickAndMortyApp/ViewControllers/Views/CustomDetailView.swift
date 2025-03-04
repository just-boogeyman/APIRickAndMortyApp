//
//  CustomDetailView.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 02.03.2025.
//

import UIKit
import Kingfisher

final class CustomDetailView: UIView {
		
	// MARK: - Private Property
	private let containerView = UIView()
	private let imageView = UIImageView()
	private let nameLabel = CustomLabel(
		font: Constants.fontLabel,
		size: Constants.sizeNameLabel
	)
	
	// MARK: - Initializers
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	@available (*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Configure
	func configure(with item: Character) {
		nameLabel.text = item.description
		fetchImage(url: item.image)
	}
}

// MARK: - Setup Views
private extension CustomDetailView {
	func setup() {
		backgroundColor = .darkGray
		addSubviews()
		setupContainerView()
		setupImage()
		setupLabel()
		layout()
	}
	
	func addSubviews() {
		addSubview(containerView)
		[imageView, nameLabel].forEach {containerView.addSubview($0)}
		[containerView, imageView, nameLabel].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
	}
	
	func setupContainerView() {
		containerView.layer.cornerRadius = 20
		containerView.backgroundColor = .lightGray
	}
	
	func setupImage() {
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 12
	}
	
	func setupLabel() {
		nameLabel.textAlignment = .left
		nameLabel.textColor = .white
		nameLabel.numberOfLines = 0
	}
}

// MARK: - Private Methods
private extension CustomDetailView {
	func fetchImage(url: String) {
		let url = URL(string: url)
		let processor = ResizingImageProcessor(referenceSize: CGSize(width: 300, height: 300))
		imageView.kf.indicatorType = .activity
		imageView.kf.setImage(
			with: url,
			options: [
				.processor(processor),
				.scaleFactor(UIScreen.main.scale),
				.transition(.fade(1)),
				.cacheOriginalImage
			])
	}
}

// MARK: - Layout
private extension CustomDetailView {
	func layout() {
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
			containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
			containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
			containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
			
			imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
			imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
			imageView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
			
			nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
			nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
			nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
		])
	}
}

// MARK: - Constants
private extension CustomDetailView {
	enum Constants {
		static let fontLabel = "Arial Rounded MT Bold"
		static let sizeNameLabel: CGFloat = 20
		static let sizeStatusLabel: CGFloat = 12
	}
}
