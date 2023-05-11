//
//  NetworkService.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 07.05.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
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
    
    func fetchMovies(from url: URL?, completion: @escaping(Result<MostPopularMovie, NetworkError>) -> Void ) {
        guard let url = url else {
            completion( .failure(.invalidURL))
            return
        }
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
