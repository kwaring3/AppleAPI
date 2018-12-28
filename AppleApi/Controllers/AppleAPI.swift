//
//  AppleAPI.swift
//  AppleApi
//
//  Created by Kevin Waring on 12/28/18.
//  Copyright © 2018 Kevin Waring. All rights reserved.
//

import Foundation

final class AppleAPI {
    
    static func searchResults(keyword: String, completionHandler: @escaping (Error?, [Result]?) -> Void) {
        
        let urlString = "https://itunes.apple.com/search?media=ebook&limit=100&term=swift"
        guard let url = URL(string: urlString) else {
            print("badURL: \(urlString)")
            return
}
 
        
        // use URLSession() to make network request to MeetupAPI
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("response status code is \(response.statusCode)")
            }
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                // decoding of JSON using JSONDecoder()
                // can throw and error so needs to be wrapped in a
                // do{} catch{}
                do {
                    let appleData = try JSONDecoder().decode(AppleBookData.self, from: data)
                    //closure captures value from network response
                    completionHandler(nil, appleData.results)
                } catch {
                    completionHandler(error, nil)
                }
            }
            
            }.resume()
}
}
