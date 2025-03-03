//
//  CustomViewCell.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 28.02.2025.
//

import UIKit

final class CustomViewCell: UIView {
	
	// MARK: - Private Property
	private let networkManager = NetworkManager.shared
	
	private let nameLabel = CustomLabel(
		font: Constants.fontLabel,
		size: Constants.sizeNameLabel
	)
	private let imageView = UIImageView()
	private let activityIndicator = UIActivityIndicatorView()
	private let statusView = UIView()
	
	
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
		fetchImage(url: item.image)
	}
}

// MARK: - Setup View
private extension CustomViewCell {
	func setupView() {
		backgroundColor = .lightGray
		layer.cornerRadius = 12
		activityIndicator.startAnimating()
		activityIndicator.hidesWhenStopped = true
		addView()
		setupImage()
		setupLabel()
		setupStatus()
		layout()
	}
	
	func addView() {
		[nameLabel, imageView, statusView].forEach {
			addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		imageView.addSubview(activityIndicator)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
	}
	
	func setupImage() {
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 12
	}
	
	func setupLabel() {
		nameLabel.textAlignment = .left
		nameLabel.numberOfLines = 0
	}
	
	func setupStatus() {
		statusView.backgroundColor = .green
		statusView.widthAnchor.constraint(equalToConstant: 14).isActive = true
		statusView.heightAnchor.constraint(equalToConstant: 14).isActive = true
		statusView.layer.cornerRadius = 7
	}
}

// MARK: - Private Methods
private extension CustomViewCell {
	func fetchImage(url: String) {
		networkManager.fetchImage(from: url) { [weak self] result in
			switch result {
			case .success(let imageData):
				self?.imageView.image = UIImage(data: imageData)
				self?.activityIndicator.stopAnimating()
			case .failure(let error):
				print(error)
			}
		}
	}
}

// MARK: - Layout
private extension CustomViewCell {
	func layout() {
		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
			imageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
			imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
			imageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
			
			nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
			nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			
			statusView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 14),
			statusView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
			
			activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
		])
	}
}


// MARK: - Constants
private extension CustomViewCell {
	enum Constants {
		static let fontLabel = "Arial Rounded MT Bold"
		static let sizeNameLabel: CGFloat = 20
	}
}
