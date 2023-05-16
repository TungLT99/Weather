//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    var weatherManager = WeatherManager1()
    let locationManager = CLLocationManager()
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBAction func btnLocationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    @IBAction func btnSearchClick(_ sender: UIButton) {
        guard txtTextInput.text != "" else {return}
        weatherManager.getFullURL(city: txtTextInput.text!)
    }
    @IBOutlet weak var txtTextInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

//MARK - Extension WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUploadUserInterface(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.weartherString)
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = String(weather.temp)
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.last != nil else {return}
        let location = locations.last
        let lat:String = String((location?.coordinate.latitude)!)
        let lon:String = String((location?.coordinate.longitude)!)
        weatherManager.firstLoadData(lat: lat, lon: lon)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

