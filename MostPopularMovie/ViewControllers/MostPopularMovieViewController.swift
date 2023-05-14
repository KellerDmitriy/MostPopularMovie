//
//  TableViewController.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 07.05.2023.
//

import UIKit

class MostPopularMovieViewController: UITableViewController{
    
    //MARK: Private properties
    private let networkManager = NetworkManager.shared
    
    private var timer: Timer?
    
    private var popularMovies: MostPopularMovie?
    
    private var filteredMovies: [Movie] = []
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return !searchBarIsEmpty && searchController.isActive
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovie(from: PopulaMovieAPI.baseURL.url)
        setupSearchController()
        tableView.rowHeight = 100
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let movie = isFiltering
        ? filteredMovies[indexPath.row]
        : popularMovies?.items[indexPath.row]
        guard let infoVC = segue.destination as? InfoMovieViewController else { return }
        infoVC.movie = movie
    }
    
    // MARK: - Private methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .darkGray
        navigationItem.searchController = searchController
        definesPresentationContext = true
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .darkGray
        }
    }
    
    private func setupNavigationBar() {
        title = "MostPopularMovie"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .white
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    private func fetchMovie(from url: URL?) {
        networkManager.fetchMovies(from: url) { [weak self] result in
            switch result {
            case .success(let mostPopularMovie):
                self?.popularMovies = mostPopularMovie
                self?.tableView.reloadData()
            case .failure(let error):
                print("error:", error)
            }
        }
    }
}
    // MARK: - Table view data source
extension MostPopularMovieViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredMovies.count : popularMovies?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = cell as? MovieCell else { return UITableViewCell() }
        let movie = isFiltering
                     ? filteredMovies[indexPath.row]
                     : popularMovies?.items[indexPath.row]
        cell.configure(with: movie!)
        return cell
    }
}


// MARK: - UISearchResultsUpdating
extension MostPopularMovieViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController){
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (_)  in
            filterContentForSearchText(searchController.searchBar.text ?? "")
      //  })
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredMovies = popularMovies?.items.filter { movie in
             movie.title.lowercased().contains(searchText.lowercased())
        } ?? []
        tableView.reloadData()
    }
}
