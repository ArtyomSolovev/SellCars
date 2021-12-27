//
//  Car.swift
//  SellCars
//
//  Created by Артем Соловьев on 26.12.2021.
//

import Foundation
// MARK: - Welcome
struct Car: Codable {
    var userId: Int = 0
    var locationCityName: String = ""
    var addDate: String = ""
    var USD: Int = 0
    var color: Color?
    var autoData: AutoData?
    var markName: String = ""
    var modelName: String = ""
    var subCategoryName: String = ""
    var photoData: PhotoData?
    var linkToView = "", title: String = ""
    var VIN: String = ""
    var plateNumber: String?
    init(){}
}

// MARK: - AutoData
struct AutoData: Codable {
    let description: String
    let year: Int
    let race: String
    let fuelName: String
    let gearboxName: String
    let driveName: String
}

// MARK: - Color
struct Color: Codable {
    let name, hex: String
}

// MARK: - PhotoData
struct PhotoData: Codable {
    let seoLinkM, seoLinkSX, seoLinkB, seoLinkF: String
}
