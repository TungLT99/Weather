//
//  WeatherData.swift
//  Clima
//
//  Created by TungLe on 24/03/2023.
//

import Foundation
struct WeatherData: Decodable {
    var id: Int
    var name: String
    var main: Main
}
struct Main: Decodable {
    var temp: Float
}
