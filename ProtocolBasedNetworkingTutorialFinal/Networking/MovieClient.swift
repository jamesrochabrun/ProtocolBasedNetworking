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
    private let apiKey : String
    
    init(configuration: URLSessionConfiguration, apiKey: String) {
        self.session = URLSession(configuration: configuration)
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(configuration: .default, apiKey: apiKey)
    }
    
    func getFeed(from movieFeedType: MovieFeed, completion: @escaping (Result<[Movie], APIError>) -> Void) {
        
        let endpoint = movieFeedType
        let request = endpoint.request
        
        print("KMREQUEST \(request)")
        
        fetch(with: request, parse: { json -> [Movie] in
            print("KMPRINT \(json)")
            return []
        }, completion: completion)
    }
}
