//
//  APIServices.swift
//  TestPv
//
//  Created by tran tu on 12/04/2022.
//

import Foundation
import Alamofire

class APIServices {
	
	let apiUrl = "https://api.themoviedb.org/3/discover/movie?api_key=26763d7bf2e94098192e629eb975dab0&page="
	
	func getDataFromApi<T: Codable>(page: Int) async throws -> T {
		let apiUrlWithPaging = apiUrl + "\(page)"
		let request = AF.request(apiUrlWithPaging, method: .get, parameters: .none, encoding: JSONEncoding.default, headers: .none)
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
