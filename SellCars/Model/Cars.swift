//
//  Cars.swift
//  SellCars
//
//  Created by Артем Соловьев on 26.12.2021.
//

import Foundation

// MARK: - Welcome
struct Cars: Codable {
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let search_result: SearchResult
}

// MARK: - SearchResult
struct SearchResult: Codable {
    let ids: [String]
}
