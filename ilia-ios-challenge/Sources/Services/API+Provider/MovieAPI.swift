//
//  MovieAPI.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 31/03/22.
//

import Foundation
import Moya

enum MovieAPI {
    case upcomingMovies(page: Int)
    case popularMovies(page: Int)
    case searchMovies(title: String)
}

extension MovieAPI: TargetType {
    
    var API_KEY: String {
            return "0d959db44c2b30eb348d0dc5be5cc1ad"
    }
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var path: String {
        switch self {
        case .upcomingMovies:
            return "movie/upcoming"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .upcomingMovies, .popularMovies, .searchMovies:
            return .get
        }
    }
        
    var sampleData: Data {
        switch self {
        case .upcomingMovies:
            return JSON.loadJSONFromBundle(bundle: Bundle.main, resourceName: "MoviesJSONMock")
        default:
            return Data()
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    var parameters: [String : Any] {
        var parameters = [String:Any]()

        switch self {
        case .upcomingMovies(let page):
            parameters["api_key"] = API_KEY
            parameters["language"] = "en-US"
            parameters["page"] = "\(page)"
            return parameters
         default:
            return parameters
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
