//
//  Movie.swift
//  TestPv
//
//  Created by tran tu on 12/04/2022.
//

import Foundation

struct MovieModal: Codable {
	let results: [Movie]?
	
}

struct Movie: Codable {
	let backdropPath: String?
	let posterPath: String?
	let title: String?
	let releaseDate: String?
	let voteAverage: Float?
}
