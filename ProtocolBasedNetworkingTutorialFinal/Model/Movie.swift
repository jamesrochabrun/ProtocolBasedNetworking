//
//  Movie.swift
//  ProtocolBasedNetworkingTutorialFinal
//
//  Created by James Rochabrun on 11/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    
    let title: String?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let coverPath: String?
}
