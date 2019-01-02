//
//  AppleBooks.swift
//  AppleApi
//
//  Created by Kevin Waring on 12/28/18.
//  Copyright © 2018 Kevin Waring. All rights reserved.
//

import Foundation


struct AppleBookData: Codable {
    let results: [Result]
}
struct Result: Codable  {
    let trackName: String
    let releaseDate: String?
    let kind: String
    let price: Double?
    let description: String?
    let averageUserRating: Double?
}
