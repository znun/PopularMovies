//
//  Model.swift
//  PopularMovies
//
//  Created by Mahmudul Hasan on 15/5/23.
//

import Foundation

struct MoviesData: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    let title: String?
    let year: String?
    let rating: Double?
    let posterImage: String?
    let overview: String?
   
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case rating = "vote_average"
        case posterImage = "poster_path"
    }
}
