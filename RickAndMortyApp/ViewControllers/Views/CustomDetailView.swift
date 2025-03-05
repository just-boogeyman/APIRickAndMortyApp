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
	private let statusLabel = CustomLabel(
		font: Constants.fontLabel,
		size: Constants.sizeNameLabel
	)
	private let locationLabel = CustomLabel(
		font: Constants.fontOriginLabel,
		size: Constants.sizeSmalLabel,
		color: .darkGray
	)
	private let statusLocationLabel = CustomLabel(
		font: Constants.fontLabel,
		size: Constants.sizeNameLabel
	)
	
	private let originLabel = CustomLabel(
		font: Constants.fontOriginLabel,
		size: Constants.sizeSmalLabel,
		color: .darkGray
	)
	private let statusOriginLabel = CustomLabel(
		font: Constants.fontLabel,
		size: Constants.sizeNameLabel
	)
	
	private let lineView = UIView()
	private let circleView = UIView()
	
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
		statusLabel.text = "\(item.status) - \(item.species)"
		statusLocationLabel.text = item.location.name
		statusOriginLabel.text = item.origin.name
		settingViewColors(status: item.status)
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
		setupLiveViews()
		layout()
	}
	
	func addSubviews() {
		addSubview(containerView)
		[imageView, statusLabel, lineView, circleView, locationLabel,
		 statusLocationLabel, statusOriginLabel, originLabel].forEach {containerView.addSubview($0)}
		[containerView, imageView, statusLabel, lineView, 
		 circleView, locationLabel, statusLocationLabel, originLabel, statusOriginLabel].forEach {
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
		statusLabel.numberOfLines = 0
		locationLabel.text = Constants.locationText
		originLabel.text = Constants.originText
	}
	
	func setupLiveViews() {
		lineView.widthAnchor.constraint(equalToConstant: 3).isActive = true
		lineView.backgroundColor = .green
		
		circleView.widthAnchor.constraint(equalToConstant: 20).isActive = true
		circleView.heightAnchor.constraint(equalToConstant: 20).isActive = true
		circleView.backgroundColor = .green
		circleView.layer.cornerRadius = 10
		
		containerView.layer.shadowOpacity = Constants.containerViewShadowOpacity
		containerView.layer.shadowOffset = Constants.containerViewShadowOffset
		containerView.layer.shadowRadius = Constants.containerViewShadowRadius
		
		circleView.layer.shadowOpacity = Constants.circleViewShadowOpacity
		circleView.layer.shadowOffset = Constants.circleViewShadowOffset
		circleView.layer.shadowRadius = Constants.circleViewShadowRadius
		
		lineView.layer.shadowOpacity = Constants.lineViewShadowOpacity
		lineView.layer.shadowOffset = Constants.lineViewShadowOffset
		lineView.layer.shadowRadius = Constants.lineViewShadowRadius
	}
}

// MARK: - Private Methods
private extension CustomDetailView {
	func fetchImage(url: String) {
		let url = URL(string: url)
		let processor = ResizingImageProcessor(referenceSize: Constants.referenceSize)
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
	
	func settingViewColors(status: String) {
		switch status {
		case "Alive":
			setupView(color: .green)
		case "Dead":
			setupView(color: .red)
		default:
			setupView(color: .systemCyan)
		}
	}
	
	private func setupView(color: UIColor) {
		circleView.backgroundColor = color
		lineView.backgroundColor = color
		containerView.layer.shadowColor = color.cgColor
	}
}

// MARK: - Layout
private extension CustomDetailView {
	func layout() {
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
			containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
			containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
			containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
			
			lineView.topAnchor.constraint(equalTo: containerView.topAnchor),
			lineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
			lineView.heightAnchor.constraint(equalToConstant: 256),
			
			circleView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
			circleView.centerXAnchor.constraint(equalTo: lineView.centerXAnchor),
			
			imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
			imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6),
			imageView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6),
			
			statusLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
			statusLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 14),
			statusLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
			
			locationLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 24),
			locationLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
			locationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
			
			statusLocationLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
			statusLocationLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
			statusLocationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
			
			originLabel.topAnchor.constraint(equalTo: statusLocationLabel.bottomAnchor, constant: 24),
			originLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
			originLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
			
			statusOriginLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 8),
			statusOriginLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
			statusOriginLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
		])
	}
}

// MARK: - Constants
private extension CustomDetailView {
	enum Constants {
		static let fontLabel = "Arial Rounded MT Bold"
		static let fontOriginLabel = "System"
		static let sizeNameLabel: CGFloat = 20
		static let sizeSmalLabel: CGFloat = 17
		static let sizeStatusLabel: CGFloat = 12
		static let cornerRadiusTen = 10
		
		static let locationText = "Last known location:"
		static let originText = "Origin:"
		
		static let referenceSize = CGSize(width: 300, height: 300)
		
		static let containerViewShadowOffset = CGSize(width: 5.0, height: 5.0)
		static let containerViewShadowOpacity: Float = 0.3
		static let containerViewShadowRadius: CGFloat = 20
		
		static let circleViewShadowOffset = CGSize(width: 0.0, height: 10.0)
		static let circleViewShadowOpacity: Float = 0.5
		static let circleViewShadowRadius: CGFloat = 10
		
		static let lineViewShadowOffset = CGSize(width: 5.0, height: 5.0)
		static let lineViewShadowOpacity: Float = 0.7
		static let lineViewShadowRadius: CGFloat = 7
	}
}
