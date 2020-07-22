//
//  GiphyNetwork.swift
//  GiphyAPI
//
//  Created by Yurii Sameliuk on 21/07/2020.
//  Copyright © 2020 Yurii Sameliuk. All rights reserved.
//

import Foundation

class GiphyNetwork {
    
    private let ApiKey = "lEbgbWt5TCzsuiqda3YfD7dPH3mGwncT"
    private let limitGifsLoaded = 10
    
    func loadData(search: String, completion: @escaping (_ response: GifArray?) -> Void) {
        
        let urlString = URL(string:"https://api.giphy.com/v1/gifs/search?api_key=\(ApiKey)&limit=\(limitGifsLoaded)&q=\(search)")!
        let request = URLRequest(url: urlString)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print("Error fetching from Giphy: ", err.localizedDescription)
            }
            do {
                DispatchQueue.main.async {
                    let object = try! JSONDecoder().decode(GifArray.self, from: data!)
                    completion(object)
                }
            }
        }.resume()
    }
}

