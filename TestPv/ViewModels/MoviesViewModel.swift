//
//  MoviesModel.swift
//  TestPv
//
//  Created by tran tu on 12/04/2022.
//

import Foundation

class MoviesViewModel {
	private var apiService: APIServices!
	var bindProductListToController: (() -> ()) = {}
	
	init() {
		apiService = APIServices()
	}
}
