//
//  TableViewController.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 07.05.2023.
//

import UIKit

class MostPopularMovieViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        fetchMovie ()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = cell as? MovieCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
}

// MARK: - SearchBarDelegate
extension MostPopularMovieViewController {
    private func fetchMovie () {
        networkManager.fetchMovies(from: networkManager.urlString) { [weak self] result in
            switch result {
            case .success(let mostPopularMovie):
                self?.movies = mostPopularMovie.items
                self?.tableView.reloadData()
            case .failure(let error):
                print("error:", error)
            }
        }
    }
}
