//
//  RequestMaker.swift
//  Pokedex
//
//  Created by Dionata Leonel Machado Ferraz on 08/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//
import Foundation

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
    typealias CompletionCallBack<T: Decodable> = (T) -> Void
    
    func make<T: Decodable>(withEndpointUrl endpoint: Endpoint, completion: @escaping CompletionCallBack<T>) {
        guard let url = URL(string: "\(baseUrl)\(endpoint.url)") else {
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                return
            }
            
            do {
                let decodedObject = try RequestMaker.decoder.decode(T.self, from: data)
                completion(decodedObject)
            } catch let error {
                print(error)
            }
        }
        
        dataTask.resume()
    }
}
