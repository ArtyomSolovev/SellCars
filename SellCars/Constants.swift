//
//  Constants.swift
//  SellCars
//
//  Created by Артем Соловьев on 27.12.2021.
//

import UIKit

enum Constants {
    
    enum Color {
        static let white = "#F5F5F5"
        static let red = "#F05454"
        static let grey = "#30475E"
        static let black = "#121212"
    }
    
    enum Store {
        static let key = "SavedHistory"
    }
    
    enum Alert {
        static let title = "Attention"
        static let message = "The search for artists did not give results, enter another artist"
        static let ok = "Okey"
    }
}

extension UIColor {
     static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
