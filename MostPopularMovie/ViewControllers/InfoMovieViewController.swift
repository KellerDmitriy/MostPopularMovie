//
//  InfoMovieViewController.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 11.05.2023.
//

import UIKit

final class InfoMovieViewController: UIViewController {
    
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: Movie!
    private var spinnerView = UIActivityIndicatorView()
    private let networkManager = NetworkManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleMovie.text = movie.title
        descriptionLabel.text = movie.description
        fetchImage()
        
     
        showSpinner(in: movieImageView)
        
    }
    // MARK: - Private Methods
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .gray
        spinnerView.startAnimating()
        spinnerView.center = movieImageView.center
        spinnerView.hidesWhenStopped = true
        view.addSubview(spinnerView)
    }
    
    
    private func fetchImage() {
        networkManager.fetchImage(from: movie.image) { result in
            switch result {
            case .success(let imageData):
                self.movieImageView.image = UIImage(data: imageData)
                self.spinnerView.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}

