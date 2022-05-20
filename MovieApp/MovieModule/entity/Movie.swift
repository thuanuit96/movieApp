//
// Movie.swift
// MovieApp
//
// Created by VN01-MAC-0006 on 18/05/2022.
//
//
import  Foundation
struct  Movie : Codable{
    var id  : Int
    var adult = false
    var title = ""
    var originalTitle = ""
    var overview = ""
    var posterPath = ""
    var releaseDate = ""
    var originalLanguage = ""
    var popularity : Float = 0
    var backdropPath = ""
    var video = false
    var voteAverage : Float = 0
    var voteCount : Int = 0
    var genreIds  = [Int]()
    var releaseYear: String {
        get {
            return releaseDate.components(separatedBy: "-")[0]
        }
    }
    var posterFullPath: String {
        get {
            print("posterFullPath :\(AppConfig.imageURLPrefix + posterPath)")
            return AppConfig.imageURLPrefix + "/w500/" + posterPath
        }
    }
    
    enum CodingKeys:String,CodingKey {
        case id
        case title
        case video
        case adult
        case overview
        case popularity
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        
    }
}


struct ResponseData: Codable {
    var page : Int
    var totalPages : Int
    var listMovie: [Movie]
    enum CodingKeys:String,CodingKey {
        case page
        case totalPages = "total_pages"
        case listMovie = "results"
    }
}

struct AddNewsParameter {
    var title: String
    var content: String
    var publicDate: Date?
    var link : String
    var imgURL : String
    
}

enum PhotoState : String ,Codable  {
    case new, downloaded, failed
}
extension Movie: Equatable { }
