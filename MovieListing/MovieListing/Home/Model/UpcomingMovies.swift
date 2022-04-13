//
//  UpcomingMovies.swift
//  MovieListing
//
//  Created by Rajasekaran Gopal on 11/04/22.
//

import Foundation


struct UpcomingMovies : Codable {

    let dates : Date?
    let page : Int?
    let results : [UPComingResult]?
    let totalPages : Int?
    let totalResults : Int?
}

struct UPComingResult : Codable {

    let adult : Bool?
    let backdropPath : String?
    let genreIds : [Int]?
    let id : Int?
    let originalLanguage : String?
    let originalTitle : String?
    let overview : String?
    let popularity : Float?
    let posterPath : String?
    let releaseDate : String?
    let title : String?
    let video : Bool?
    let voteAverage : Float?
    let voteCount : Int?

}

struct Date : Codable {

    let maximum : String?
    let minimum : String?

}
