//
//  CustomLable.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 03.03.2025.
//

import UIKit

final class CustomLabel: UILabel {
		
	init(font: String, size: CGFloat) {
		super.init(frame: .zero)
		setupLabel(fontName: font, size: size)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

// MARK: - SetupLabel
extension CustomLabel {
	private func setupLabel(fontName: String, size: CGFloat) {
		font = UIFont(name: fontName, size: size)
		textColor = .white
		textAlignment = .center
	}
}

