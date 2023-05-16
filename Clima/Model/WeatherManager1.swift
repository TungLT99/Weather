//
//  WeatherManager1.swift
//  Clima
//
//  Created by TungLe on 23/03/2023.
//

import Foundation
protocol WeatherManagerDelegate {
    func didUploadUserInterface(weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager1 {
    var delegate:WeatherManagerDelegate?
    var apiURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    var apiKey = "appid=ec5ce0b06a1e5e0087139544eeca77c4"
    func getFullURL(city : String) {
        let fullAPI = apiURL + "&" + apiKey + "&" + "q=\(city)"
        performRequest(fullAPI: fullAPI)
    }
    func performRequest(fullAPI: String) {
        //1 Create an URL
        let url = URL(string: fullAPI)
        //2 Create URL session
        let urlSession = URLSession(configuration: .default)
        //3 Give session a task
        let task = urlSession.dataTask(with: url!, completionHandler: handledata(data:urlResponse:error:))
        //4 Begin task
        task.resume()
    }
    func handledata(data:Data?, urlResponse:URLResponse?, error:Error?) {
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            let weather = extractDataJSON(weatherData: safeData)!
            delegate?.didUploadUserInterface(weather: weather)
        }
        guard error != nil else {return}
        self.delegate?.didFailWithError(error: error!)
        
    }
    func extractDataJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            let weatherModel = WeatherModel(id: decoderData.id, cityName: decoderData.name, temp: decoderData.main.temp)
            return weatherModel
        }
        catch {
            self.delegate?.didFailWithError(error: error)
                return nil
        }
        
    }
    func firstLoadData(lat: String, lon: String) {
        let url:String = self.apiURL + "&" + self.apiKey + "&" + "lat=\(lat)&lon=\(lon)"
        performRequest(fullAPI: url)
    }
    
    
}
