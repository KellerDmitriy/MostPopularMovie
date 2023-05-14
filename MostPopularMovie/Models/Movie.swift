//
//  Movie.swift
//  MostPopularMovie
//
//  Created by Келлер Дмитрий on 05.05.2023.
//

import Foundation

struct MostPopularMovie {
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
        imDbRating = movieData["imDbRating"] as? String ?? "no rating"
        crew = movieData["crew"] as? String ?? ""
    }
    
    var description: String {
        """
    year: \(year)
    imDbRating: \(imDbRating)
    crew: \(crew)
    """
    }
    
    static func getMovies(from value: Any) -> [Movie] {
        guard let items = value as? [String: Any] else { return []}
        guard let movieData = items["items"] as? [[String: Any]] else { return [] }
        return movieData.map { Movie(from: $0) }
    }
    
    var director: String {
        let crewArray = crew.components(separatedBy: ",")
        guard let firstDirector = crewArray.first(where: { $0.hasPrefix("(dir.)") }) ?? crewArray.first else {
            return ""
        }
        return firstDirector
    }
    
  
}



