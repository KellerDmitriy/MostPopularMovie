//
//  MovieCell.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 09.05.2023.
//

import UIKit

final class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
//    {
//        didSet {
//           movieImage.contentMode = .scaleAspectFit
//            movieImage.clipsToBounds = true
//            movieImage.layer.cornerRadius = movieImage.frame.height / 2
//        }
//    }
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    @IBOutlet weak var crewLabel: UILabel!
    
    private let networkService = NetworkManager.shared
    
    func configure(with movie: Movie) {
        movieTitle.text = movie.title
        movieYearLabel.text = "year: \(movie.year)"
        movieRating.text = "imDbRating: \(movie.imDbRating)"
        crewLabel.text = "by: \(movie.director)"
        
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

