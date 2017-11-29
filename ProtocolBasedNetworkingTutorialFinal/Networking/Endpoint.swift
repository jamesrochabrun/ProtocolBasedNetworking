//
//  Endpoint.swift
//  ProtocolBasedNetworkingTutorialFinal
//
//  Created by James Rochabrun on 11/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    
    var apiKey: String {
        return "api_key=34a92f7d77a168fdcd9a46ee1863edf1"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = apiKey
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum MovieFeed {
    
    case nowPlaying
    case topRated
}

extension MovieFeed: Endpoint {
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .nowPlaying: return "/3/movie/now_playing"
        case .topRated: return "/3/movie/top_rated"
        }
    }
}








