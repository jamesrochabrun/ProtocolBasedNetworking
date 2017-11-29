//
//  MovieFeed.swift
//  ProtocolBasedNetworkingTutorialFinal
//
//  Created by James Rochabrun on 11/28/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation

struct MovieFeedResult: Decodable {
    let results: [Movie]?
}
