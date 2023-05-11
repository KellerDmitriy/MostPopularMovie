//
//  Movie.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 05.05.2023.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let year: String
    let image: URL
    let imDbRating: String
    let crew: String
    
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
}

struct MostPopularMovie: Decodable {
    let items: [Movie]
}



enum PopulaMovieAPI {
    case baseURL
    
    var url: URL {
        switch self {
        case .baseURL:
            return URL(string: "https://imdb-api.com/en/API/MostPopularMovies/k_88im04e6")!
        }
    }
}


