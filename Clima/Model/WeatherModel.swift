//
//  WeatherModel.swift
//  Clima
//
//  Created by TungLe on 28/03/2023.
//

import Foundation
struct WeatherModel {
    let id:Int
    let cityName:String
    var weartherString: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    var temp: Float
    
}
