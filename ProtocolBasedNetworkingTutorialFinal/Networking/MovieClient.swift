//
//  MovieClient.swift
//  ProtocolBasedNetworkingTutorialFinal
//
//  Created by James Rochabrun on 11/28/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation

class MovieClient: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getFeed(from movieFeedType: MovieFeed, completion: @escaping (Result<MovieFeedResult, APIError>) -> Void) {
        
        let endpoint = movieFeedType
        let request = endpoint.request
        
        fetch(with: request, parse: { json -> MovieFeedResult in
            return json as! MovieFeedResult
        }, completion: completion)
    }
}
