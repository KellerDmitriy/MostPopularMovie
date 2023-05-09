//
//  NetworkService.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 07.05.2023.
//

import Foundation

enum NetworkError: Error {
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    let urlString = "https://imdb-api.com/en/API/MostPopularMovies/k_88im04e6"
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion( .failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion( .success(imageData))
            }
        }
    }
    
    func fetchMovies(from urlString: String, completion: @escaping(Result<MostPopularMovie, NetworkError>) -> Void ) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let mostPopularMovie = try decoder.decode(MostPopularMovie.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(mostPopularMovie))  
                }
            } catch {
                completion(.failure(.decodingError))
            }
        } .resume()
    }
}
