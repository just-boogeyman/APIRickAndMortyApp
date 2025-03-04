//
//  Characters.swift
//  RickAndMortyApp
//
//  Created by Ярослав Кочкин on 26.02.2025.
//

import Foundation

struct Characters: Decodable {
	let info: Info
	let results: [Character]
}

struct Info: Decodable {
	let count: Int
	let pages: Int
	let next: String
}

struct Character: Decodable {
	let id: Int
	let name: String
	let status: String
	let species: String
	let image: String
	let location: Location
	let origin: Location
	
	var description: String {
		"""
		Name: \(name)
		Status: \(status)
		Species: \(species)
		Origin: \(origin.name)
		Location: \(location.name)
		"""
	}
}

struct Location: Decodable {
	let name: String
}
