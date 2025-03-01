//
//  Characters.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 26.02.2025.
//

import Foundation

struct Character: Decodable {
	let info: Info
	let results: [Results]
}

struct Info: Decodable {
	let count: Int
	let pages: Int
	let next: String
}

struct Results: Decodable {
	let id: Int
	let name: String
	let status: String
	let species: String
	let image: String
	let location: Location
	let origin: Location
}

struct Location: Decodable {
	let name: String
}
