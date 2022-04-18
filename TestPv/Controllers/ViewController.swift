//
//  ViewController.swift
//  TestPv
//
//  Created by tran tu on 12/04/2022.
//

import UIKit

class ViewController: UIViewController {
	var movieViewModel: MoviesViewModel!
	@IBOutlet weak var movieList: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.movieViewModel = MoviesViewModel()
		self.movieViewModel.bindProductListToController = {
			DispatchQueue.main.async {
				self.movieList.reloadData()
			}
		}
		let cell = UINib(nibName: "CustomCell", bundle: nil)
		movieList.register(cell, forCellReuseIdentifier: "customCell")
		movieList.separatorStyle = .none
		movieList.delegate = self
		movieList.dataSource = self
	}

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (movieViewModel.movieList.count)/2
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let _cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
		guard let cell = _cell as? CustomCell else {return _cell}
		let leftMovieIndex = movieViewModel.getIndexForTheLeftMovie(rowIndex: indexPath.row)
		let leftMovie = movieViewModel.movieList[leftMovieIndex]
		let leftImageUrl = movieViewModel.getFullImageUrl(imageUrl: leftMovie.posterPath ?? leftMovie.backdropPath)
		cell.bindDataForCell(cellData: leftMovie, isleftMovie: true, imageUrl: leftImageUrl)

		let rightMovieIndex = movieViewModel.getIndexForTheRightMovie(rowIndex: indexPath.row)
		guard let rightMovieIndex = rightMovieIndex else { return cell }
		let rightMovie = movieViewModel.movieList[rightMovieIndex]
		let rightImageUrl = movieViewModel.getFullImageUrl(imageUrl: rightMovie.posterPath ?? rightMovie.backdropPath)
		cell.bindDataForCell(cellData: rightMovie, isleftMovie: false, imageUrl: rightImageUrl)
		cell.layer.borderWidth = 0
		return cell
	}
}

extension ViewController: UIScrollViewDelegate {
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let position = scrollView.contentOffset.y
		if position == 0 {
			movieViewModel.getDataByPage(page: 1)
			return
		}
		movieViewModel.getDataForNextPage()
	}
}

