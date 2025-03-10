//
//  InfoViewController.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 05.03.2025.
//

import UIKit

final class InfoViewController: UIViewController {
	
	// MARK: - Lazy Properties
	private lazy var scrollView = UIScrollView()
	private lazy var contentView = UIView()
	private lazy var titleLabel = CustomLabel(font: "Arial Rounded MT Bold", size: 16)
	private lazy var textLabel = CustomLabel(font: "Arial Rounded MT Bold", size: 14)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
}


// MARK: - Setting View
private extension InfoViewController {
	func setupView() {
		view.backgroundColor = .lightGray
		addSubviews()
		settupScrollView()
		setupContentView()
		setupLable()
		setupLayout()
	}
	
	func addSubviews() {
		view.addSubview(scrollView)
	}
}

// MARK: - Setting Subviews
private extension InfoViewController {
	
	func settupScrollView() {
		scrollView.backgroundColor = .lightGray
		scrollView.addSubview(contentView)
	}
	
	func setupContentView() {
		contentView.backgroundColor = .white
		contentView.addSubview(titleLabel)
		contentView.addSubview(textLabel)
	}
	
	func setupLable() {
		titleLabel.text = TextManager.title
		textLabel.text = TextManager.text
		textLabel.textAlignment = .justified
		titleLabel.textColor = .black
		textLabel.textColor = .black
		titleLabel.numberOfLines = 0
		textLabel.numberOfLines = 0
		titleLabel.textAlignment = .center
	}
}

// MARK: - Layout
private extension InfoViewController {
	func setupLayout() {
		[scrollView, contentView, textLabel, titleLabel]
			.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			
			contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
			contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),
			contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24),
			contentView.heightAnchor.constraint(equalToConstant: 800),
			
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

			textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
			textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
		])
	}
}

private extension InfoViewController {
	enum TextManager {
			
		static var title = "LICENSED APPLICATION"

		static var text = """
		Привет, уважаемый Разработчик, этим
		приложением я хотел продемонстрировать -
		возможности работы с: UISearchController,
		UISearchBar, UIRefreshControl, scopeBar,
		Kingfisher.
		Возможности сортировки через scopeBar по
		категориям. Так же работу через менаджера
		зависимостей Kingfisher, что позволяет
		кэшировать картинки и с легкостью отображать
		их визуально и красиво, и возможностью
		очистить память через кнопку Trash.
		UIRefreshControl - продемонстрирована работа
		по загрузке данных из сети при использовании
		UIRefreshControl, что позволяет получить 
		данные из сети и передать новые данные
		в таблицу, для дальнейшего отображения,
		обновления таблицы, при работе refresh,
		scopeBar возвращается в положение All, если
		был в другом положении.
		----------------------------------------
		Отличная статья по UISearchController:
		https://debash.medium.com/uisearchcontroller-48dbc0f4cb63
		"""
	}

}
