//
//  MovieCell.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 09.05.2023.
//

import UIKit

final class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    
    private let networkService = NetworkManager.shared
    
    func configure(with movie: Movie) {
        movieTitle.text = movie.title
        movieYearLabel.text = "year: \(movie.year)"
        movieRating.text = "imDbRating: \(movie.imDbRating))"
        
        networkService.fetchImage(from: movie.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.movieImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}

