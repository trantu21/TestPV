//
//  MoviesModel.swift
//  TestPv
//
//  Created by tran tu on 12/04/2022.
//

import Foundation

class MoviesViewModel {
	private var apiService: APIServices!
	var movieList: [Movie] = [] {
		didSet {
			self.bindProductListToController()
		}
	}

	private var config: ConfigsModel? {
		didSet {
			self.bindProductListToController()
		}
	}
	var bindProductListToController: (() -> ()) = {}
	
	init() {
		apiService = APIServices()
		Task {
			do {
//				let movieModal = try await getMoviesFromAPI(page: 1)
//				movieList.append(contentsOf: movieModal.results ?? [])
//				let temp = movieList
//				movieList = temp
				getDataByPage(page: 1)
				config = try await getConfigFromAPI()
			} catch {
				debugPrint(error)
			}
		}
	}
	
	func getDataByPage(page: Int) {
		if page == 1 {movieList.removeAll()}
		Task {
			do {
				let movieModal = try await getMoviesFromAPI(page: page)
				movieList.append(contentsOf: movieModal.results ?? [])
				let temp = movieList
				movieList = temp
			} catch {
				debugPrint(error)
			}
		}
	}
	
	func getDataForNextPage() {
		let page = movieList.count / 20 + 1
		getDataByPage(page: page)
	}

	func getFullImageUrl(imageUrl: String?) -> String {
		guard let imageConfig = config?.images, let imageUrl = imageUrl else { return ""}
		let fullImageUrl = imageConfig.baseUrl! + imageConfig.posterSizes![3] + imageUrl
		return fullImageUrl
	}
	
	func getIndexForTheLeftMovie(rowIndex: Int) -> Int {
		if movieList.isEmpty {return 0}
		let lastIndex = movieList.count - 1
		let leftIndex = rowIndex * 2
		return leftIndex > lastIndex ? lastIndex: leftIndex
	}
	
	func getIndexForTheRightMovie(rowIndex: Int) -> Int? {
		let leftIndex = getIndexForTheLeftMovie(rowIndex: rowIndex)
		if leftIndex >= movieList.count - 1 {return nil}
		return leftIndex + 1
	}
	
	private func getMoviesFromAPI(page: Int) async throws -> MovieModal {
		try await apiService.fetchDataByAPIType(page: page, type: .movies)
	}
	
	private func getConfigFromAPI() async throws -> ConfigsModel {
		try await apiService.fetchDataByAPIType(page: 0, type: .config)
	}
	
}
