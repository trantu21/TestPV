//
//  APIServices.swift
//  TestPv
//
//  Created by tran tu on 12/04/2022.
//

import Foundation
import Alamofire

class APIServices {
	enum APIType: String {
		case movies
		case config
		var apiUrl: String {
			switch self {
			case .movies:
				return "https://api.themoviedb.org/3/discover/movie?api_key=26763d7bf2e94098192e629eb975dab0&page="
			case .config:
				return "https://api.themoviedb.org/3/configuration?api_key=26763d7bf2e94098192e629eb975dab0"
			}
		}
	}
	
	func fetchDataByAPIType<T: Codable>(page: Int, type: APIType) async throws -> T {
		if type == .movies {
			let apiUrlWithPaging = type.apiUrl + "\(page)"
			return try await fetchDataFromApi(apiUrl: apiUrlWithPaging)
		}
		return try await fetchDataFromApi(apiUrl: type.apiUrl)
	}
	
	
	func fetchDataFromApi<T: Codable>(apiUrl: String) async throws -> T {
		let request = AF.request(apiUrl, method: .get, parameters: .none, encoding: JSONEncoding.default, headers: .none)
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		let defaultDataProcesscer = DecodableResponseSerializer<T>.defaultDataPreprocessor
		let defaultResponseSerializer = DecodableResponseSerializer<T>.defaultEmptyResponseCodes
		let defaultResponseMethod = DecodableResponseSerializer<T>.defaultEmptyRequestMethods
		let decoded = request.serializingDecodable(T.self, automaticallyCancelling: false, dataPreprocessor: defaultDataProcesscer, decoder: decoder, emptyResponseCodes: defaultResponseSerializer, emptyRequestMethods: defaultResponseMethod)
		let value = try await decoded.value
		return value
	}

}
