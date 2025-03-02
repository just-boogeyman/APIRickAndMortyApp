//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 26.02.2025.
//

import Foundation

enum RickAndMortyAPI: String {
	case characters = "https://rickandmortyapi.com/api/character?page=1"
	case locations = "https://rickandmortyapi.com/api/location"
	case episodes = "https://rickandmortyapi.com/api/episode"
}

enum NetworkError: Error {
	case invalidURL
	case noData
	case decodingError
}

final class NetworkManager {
	
	static let shared = NetworkManager()
	
	private init() {}
	
	func fetch<T: Decodable>(_ type: T.Type, url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
		guard let url = URL(string: url) else {
			completion(.failure(.invalidURL))
			return
		}
		URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data = data else {
				completion(.failure(.noData))
				return
			}
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let type = try decoder.decode(T.self, from: data)
				DispatchQueue.main.async {
					completion(.success(type))
				}
			} catch {
				completion(.failure(.decodingError))
			}
		}.resume()
	}
	
	func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
		guard let url = URL(string: url ?? "") else {
			completion(.failure(.invalidURL))
			return
		}
		
		DispatchQueue.global().async { // в фоновом потоке пытаемся получить imageData из ссылки
			guard let imageData = try? Data(contentsOf: url) else { 
				completion(.failure(.noData))
				return
			}
			DispatchQueue.main.async { // переходим в основной поток
				completion(.success(imageData))
			}
		}
	}
}
