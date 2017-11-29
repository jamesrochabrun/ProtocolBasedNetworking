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
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getFeed(from movieFeedType: MovieFeed, completion: @escaping (Result<MovieFeedResult?, APIError>) -> Void) {
        
        let endpoint = movieFeedType
        let request = endpoint.request
        
        fetch(with: request, decode: { json -> MovieFeedResult? in
            guard let movieFeedResult = json as? MovieFeedResult else { return  nil }
            return movieFeedResult
        }, completion: completion)
    }
}





