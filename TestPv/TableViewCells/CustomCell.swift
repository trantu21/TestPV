//
//  CustomCell.swift
//  TestPv
//
//  Created by tran tu on 13/04/2022.
//

import UIKit

class CustomCell: UITableViewCell {
	@IBOutlet weak var leftImage: UIImageView!
	@IBOutlet weak var leftName: UILabel!
	@IBOutlet weak var leftYear: UILabel!
	@IBOutlet weak var leftPoint: UILabel!
	
	@IBOutlet weak var rightImage: UIImageView!
	@IBOutlet weak var rightName: UILabel!
	@IBOutlet weak var rightYear: UILabel!
	@IBOutlet weak var rightPoint: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	func mappingData(leftMovie: Movie, rightMovie: Movie, leftImageUrl: String, rightImage: String) {
		bindDataForCell(cellData: leftMovie, isleftMovie: true, imageUrl: leftImageUrl)
	}
	
	func bindDataForCell(cellData: Movie?, isleftMovie: Bool, imageUrl: String) {
		if cellData == nil {return}
		if isleftMovie {
			setImage(imageUrl: imageUrl, imageView: leftImage)
			guard let cellData = cellData else { return }
			leftName.text = cellData.title
			leftYear.text = cellData.releaseDate
			let text = String(format: "%.1f", cellData.voteAverage!)
			setUpPointLabel(label: leftPoint, text: text)
			setUpMovieView(_view: leftImage)
			return
		}
		
		setImage(imageUrl: imageUrl, imageView: rightImage)
		guard let cellData = cellData else { return }
		rightName.text = cellData.title
		rightYear.text = cellData.releaseDate
		let text = String(format: "%.1f", cellData.voteAverage!)
		setUpPointLabel(label: rightPoint, text: text)
		setUpMovieView(_view: rightImage)
	}
	
	private func setUpPointLabel(label: UILabel, text: String) {
		label.backgroundColor = UIColor(red: 1.00, green: 0.60, blue: 0.40, alpha: 1.00)
		label.layer.masksToBounds = true
		label.layer.cornerRadius = 10
		let attributedString = NSMutableAttributedString(string: text)
		attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: 1))
		label.attributedText = attributedString
	}
	
	private func setUpMovieView(_view: UIView) {
		_view.layer.cornerRadius = 5
		_view.backgroundColor = .cyan
		_view.layer.shadowOpacity = 1
		guard let container = _view.superview else { return }
		container.layer.cornerRadius = 5
		container.layer.shadowOpacity = 1
	}
	
	
	private func setImage(imageUrl: String, imageView: UIImageView) {
		DispatchQueue.main.async {
			imageView.image = UIImage(systemName: "photo.artframe")
		}
		if imageUrl == "" {return}
		let url = URL(string: imageUrl)
		DispatchQueue.global().async {
			let data = try? Data(contentsOf: url!)
			guard let data = data else {return}
			DispatchQueue.main.async {
				imageView.image = UIImage(data: data)
			}
		}
	}
}

