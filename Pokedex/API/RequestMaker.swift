//
//  RequestMaker.swift
//  Pokedex
//
//  Created by Dionata Leonel Machado Ferraz on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//
import Foundation

enum RequestMakeError: Error {
    case malformedURL
    case requestFailed
    case invalidData
    case decodingFailed
}

class RequestMaker {
    static let decoder = JSONDecoder()
    
    enum Endpoint {
        case list
        case details(query: String)
        
        var url: String {
            switch self {
            case .list:
                return "list"
            case let .details(query):
                return "details/\(query)"
            }
        }
    }
    
    let baseUrl = "http://localhost:3000/"
    let session = URLSession.shared
    typealias RequestResult<T> = Result<T, RequestMakeError>
    typealias CompletionCallBack<T: Decodable> = (RequestResult<T>) -> Void
    typealias SuccessCallBack<T: Decodable> = (T) -> Void
    
    func make<T: Decodable>(withEndpointUrl endpoint: Endpoint, completion: @escaping SuccessCallBack<T>) {
        make(withEndpointUrl: endpoint) { (result: RequestResult<T>) in
            switch result {
            case .success(let object):
                completion(object)
                
            case .failure:
                break
            }
        }
    }
    
    func make<T: Decodable>(withEndpointUrl endpoint: Endpoint, completion: @escaping CompletionCallBack<T>) {
        guard let url = URL(string: "\(baseUrl)\(endpoint.url)") else {
            completion(.failure(.malformedURL))
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedObject = try RequestMaker.decoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch let error {
                completion(.failure(.decodingFailed))
                print(error)
            }
        }
        
        dataTask.resume()
    }
}
