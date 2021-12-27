//
//  Network.swift
//  SellCars
//
//  Created by Артем Соловьев on 26.12.2021.
//

import Foundation

final class Network {
    
    static let instance = Network()
    
    func getCars (complition: @escaping (Cars)->()) {
        guard let url = URL(string: "https://developers.ria.com/auto/search?api_key=CMSuUf0R2ZUGwZr3xq8RxSKDVICbLj33ua9qk0hN") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Cars.self, from: data)
                    complition(result)
                    print(result)
                } catch {
                    print(error.localizedDescription)
                }
            }
            if error != nil {
                print(error?.localizedDescription ?? "Error unknown")
            }
        }.resume()
    }

    func getCar (id: String, complition: @escaping (Car)->()) {
        guard let url = URL(string: "https://developers.ria.com/auto/info?api_key=CMSuUf0R2ZUGwZr3xq8RxSKDVICbLj33ua9qk0hN&auto_id=\(id)") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                print(url)
                do {
                    let result = try JSONDecoder().decode(Car.self, from: data)
                    complition(result)
                    print(result)
                } catch {
                    print(error.localizedDescription)
                }
            }
            if error != nil {
                print(error?.localizedDescription ?? "Error unknown")
            }
        }.resume()
    }
    
}
