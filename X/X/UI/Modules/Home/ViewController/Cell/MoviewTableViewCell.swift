//
//  MoviewTableViewCell.swift
//  X
//
//  Created by iosDev on 30.11.2022.
//

import Foundation
import UIKit

class MoviewTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var reliaseLabel: UILabel!
    @IBOutlet private weak var arrowButton: UIButton!
    @IBOutlet private weak var trailerButton: UIButton!
    
    // MARK: - Public properties
    var onMoreAction: (() -> Void)?
    var onTrailerAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        genreLabel.text = nil
        durationLabel.text = nil
        descriptionLabel.text = nil
        ratingLabel.text = nil
        reliaseLabel.text = nil
    }
    
    // MARK: - Private methods
    private func setupViews() {
        containerView.layer.cornerRadius = 5
        trailerButton.layer.cornerRadius = 5
        movieImage.layer.cornerRadius = 5
        movieImage.layer.masksToBounds = true
        arrowButton.addTarget(self, action: #selector(moreAction(sender:)), for: .touchUpInside)
        trailerButton.addTarget(self, action: #selector(trailerAction(sender:)), for: .touchUpInside)
    }
    
    private func showMoreState(_ isExpanded: Bool, _ text: String) {
        if !text.isThruncate() {
            arrowButton.isHidden = true
            return
        }
        if isExpanded {
            descriptionLabel.numberOfLines = 0
            arrowButton.setTitle("Hide", for: .normal)
            return
        }
        descriptionLabel.numberOfLines = 2
        arrowButton.setTitle("Show more", for: .normal)
    }
    
    @objc private func moreAction(sender: UIButton) {
        onMoreAction?()
    }
    
    @objc private func trailerAction(sender: UIButton) {
        onTrailerAction?()
    }
    
    // MARK: - Public methods
    func configure(_ model: CellModel) {
        nameLabel.text = model.movie.title
        descriptionLabel.text = model.movie.description
        genreLabel.text = "Genre: " + model.movie.genre
        ratingLabel.text = "Rating: " + model.movie.rating.asString()
        reliaseLabel.text = "Release date: " + model.movie.releasedDate
        durationLabel.text = "Duration: " + model.movie.duration
        showMoreState(model.isExpanded, model.movie.description)
    }
    
}
