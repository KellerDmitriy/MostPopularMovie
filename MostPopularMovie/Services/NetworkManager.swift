//
//  NetworkService.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 07.05.2023.
//

import Foundation
import Alamofire


final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let dataImage):
                    completion(.success(dataImage))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
    func fetchMovies(from url: String, completion: @escaping(Result<[Movie], AFError>) -> Void ) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let movies = Movie.getMovies(from: value)
                    completion(.success(movies))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
