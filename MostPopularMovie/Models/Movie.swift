//
//  Movie.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 05.05.2023.
//

import Foundation

struct MostPopularMovie: Decodable {
    let items: [Movie]
}

struct Movie: Decodable {
    let title: String
    let year: String
    let image: String
    let imDbRating: String
    let crew: String
    
    init(from movieData: [String: Any]) {
        title = movieData["title"] as? String ?? ""
        year = movieData["year"] as? String ?? ""
        image = movieData["image"] as? String ?? ""
        imDbRating = movieData["imDbRating"] as? String ?? ""
        crew = movieData["crew"] as? String ?? ""
    }
    
    var description: String {
        """
    year: \(year)
    imDbRating: \(imDbRating)
    crew: \(crew)
    """
    }
    
    var director: String {
        let crewArray = crew.components(separatedBy: ",")
        guard let firstDirector = crewArray.first(where: { $0.hasPrefix("(dir.)") }) ?? crewArray.first else {
            return ""
        }
        return firstDirector
    }
    
    static func getMovies(from value: Any) -> [Movie] {
        guard let data = value as? [String: Any] else { return []}
        guard let movieData = data["data"] as? [[String: Any]] else { return [] }
        return movieData.map { Movie(from: $0) }
    }
}


enum MostPopularMovieAPI {
    case baseURL
    
    var url: String {
        switch self {
        case .baseURL:
            return "https://imdb-api.com/en/API/MostPopularMovies/k_88im04e6"
        }
    }
}


