//
//  CustomDetailView.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 02.03.2025.
//

import UIKit

final class CustomDetailView: UIView {
	
	// MARK: - Private Property
	private let containerView = UIView()
	private let imageView = UIImageView()
	private let nameLabel = UILabel()
	private let activityIndicator = UIActivityIndicatorView()
	
	private let networkManager = NetworkManager.shared
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	@available (*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Configure
	func configure(with item: Results) {
		nameLabel.text = item.name
		fetchImage(url: item.image)
	}
}

// MARK: - Setup Views
private extension CustomDetailView {
	func setup() {
		backgroundColor = .white
		addSubviews()
		activityIndicator.startAnimating()
		activityIndicator.hidesWhenStopped = true
		setupContainerView()
		setupImage()
		setupLabel()
		layout()
	}
	
	func addSubviews() {
		addSubview(containerView)
		[imageView, nameLabel].forEach {containerView.addSubview($0)}
		imageView.addSubview(activityIndicator)
		
		[containerView, imageView, nameLabel, activityIndicator].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
	}
	
	func setupContainerView() {
		containerView.layer.cornerRadius = 20
		containerView.backgroundColor = .gray
	}
	
	func setupImage() {
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 12
	}
	
	func setupLabel() {
		nameLabel.textAlignment = .center
		nameLabel.textColor = .white
	}
}

// MARK: - Private Methods
private extension CustomDetailView {
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
private extension CustomDetailView {
	func layout() {
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
			containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
			containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
			containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
			
			imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
			imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
			imageView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
			
			activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
			
			nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
			nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
			nameLabel.heightAnchor.constraint(equalToConstant: 40)
		])
	}
}
