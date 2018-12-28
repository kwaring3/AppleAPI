//
//  NetworkHelper.swift
//  AppleApi
//
//  Created by Kevin Waring on 12/28/18.
//  Copyright © 2018 Kevin Waring. All rights reserved.
//

import Foundation

final class NetworkHelper {
    static func performDataTask(urlString: String, httpMethod: String, completionHandler: @escaping (Error?, Data?) ->Void) {
        guard let url = URL(string: urlString) else {
            print("badURL: \(urlString)")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completionHandler(error, nil)
            }
            if let response = response as? HTTPURLResponse {
                print("response status code is \(response.statusCode)")
            }
            if let data = data {
                completionHandler(nil, data)
            }
            }.resume()
    }
}
