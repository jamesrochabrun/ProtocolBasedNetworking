//
//  ViewController.swift
//  ProtocolBasedNetworkingTutorialFinal
//
//  Created by James Rochabrun on 11/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

class MovieFeedViewController: UIViewController {
    
    lazy var client: MovieClient = {
        return MovieClient(apiKey: "api_key=34a92f7d77a168fdcd9a46ee1863edf1")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client.getFeed(from: .topRated) { result in
            print("KMRESULT \(result)")
        }
    }
}

