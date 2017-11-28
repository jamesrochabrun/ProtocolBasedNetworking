//
//  GenericAPIClient.swift
//  ProtocolBasedNetworkingTutorialFinal
//
//  Created by James Rochabrun on 11/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

protocol APIClient {
    
    var session: URLSession { get }
    func fetch<T: JSONDecoder>(with request: URLRequest, parse: @escaping (JSONDecoder) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
    func fetch<T: JSONDecoder>(with request: URLRequest, parse: @escaping (JSONDecoder) -> [T], completion: @escaping (Result<[T], APIError>) -> Void)
    
}

extension APIClient {
    
    typealias JSONTaskCompletionHandler = (JSONDecoder?, APIError?) -> Void
    
    func jsonTask<T: JSONDecoder>(with request: URLRequest, type: T.Type, completionHandler completion: @escaping (JSONDecoder?, APIError?) -> Void) -> URLSessionDataTask {
       
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(Movie.self, from: data)
                       //   completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    func fetch<T: JSONDecoder>(with request: URLRequest, parse: @escaping (JSONDecoder) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = jsonTask(with: request, type: T.self) { (json , error) in
            
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                if let value = parse(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
    
    func fetch<T: JSONDecoder>(with request: URLRequest, parse: @escaping (JSONDecoder) -> [T], completion: @escaping (Result<[T], APIError>) -> Void) {
        
        let task = jsonTask(with: request) { (json , error) in
            
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                let value = parse(json)
                
                if !value.isEmpty {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
}




















