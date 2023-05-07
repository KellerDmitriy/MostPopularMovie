//
//  TableViewController.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 07.05.2023.
//

import UIKit

final class TableViewController: UITableViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
    }
    
    private func request() {
        let urlString = "https://imdb-api.com/en/API/MostPopularMovies/k_88im04e6"
        fetchMovie(urlString: urlString) { (result) in
            switch result {
            case .success(let searchMovie):
                searchMovie.items.map { (movie) in
                    print(
                        "Movie:", movie.title,
                        movie.year,
                        "(imDbRating: \(movie.imDbRating ?? "not found"))"
                    )
                }
            case .failure(let error):
                print("error:", error)
            }
        }
    }
    
    private func fetchMovie(urlString: String, completion: @escaping (Result<SearchMovie, Error>) -> Void ) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    completion(.failure(error))
                    return
                }
                do {
                    let movies = try JSONDecoder().decode(SearchMovie.self, from: data)
                    completion(.success(movies) )
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        } .resume()
    }

}
