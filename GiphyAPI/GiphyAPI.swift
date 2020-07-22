//
//  GiphyAPI.swift
//  GiphyAPI
//
//  Created by Yurii Sameliuk on 21/07/2020.
//  Copyright © 2020 Yurii Sameliuk. All rights reserved.
//

import Foundation

// Array of Gif objects.
struct GifArray: Decodable {
    var gifs: [Gif]
    enum CodingKeys: String, CodingKey {
        case gifs = "data"
    }
}
// Contains giph properties
struct Gif: Decodable {
    var gifSources: GifImages
    enum CodingKeys: String, CodingKey {
        case gifSources = "images"
    }
    
    // Returns download url of the originial gif
    func getGifURL() -> String {
        return gifSources.original.url
    }
}
// Stores the original Gif
struct GifImages: Decodable {
    var original: original
    enum CodingKeys: String, CodingKey {
        case original = "original"
    }
}
// URL to data of Gif
struct original: Decodable {
    var url: String
}