//
//  ImageModel.swift
//  TestPv
//
//  Created by tran tu on 13/04/2022.
//

import Foundation

struct ConfigsModel: Codable {
	let images: Config?
}

struct Config: Codable {
	let baseUrl: String?
	let posterSizes: [String]?
}
