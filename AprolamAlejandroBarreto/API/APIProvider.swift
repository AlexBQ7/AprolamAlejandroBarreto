//
//  APIProvider.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 11/08/22.
//

import Foundation

final class APIProvider {
    
    static let shared = APIProvider()
    private let base_url = "https://gnews.io/api/v4/search"
    private let api_key = "435ef8430c2a4c0d7179424d7040966b"
    
    func getNews(success: @escaping (_ response: [News]) -> (), failure: @escaping (_ error: String?) -> ()) {
        let url = "\(base_url)?q=Lactancia%20materna&token=\(api_key)"
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                //let response = try JSONSerialization.data(withJSONObject: data, options: [])
                let response = try JSONDecoder().decode(Article.self, from: data)
                print(response)
                success(response.articles)
            } catch {
                print(error)
                failure(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
