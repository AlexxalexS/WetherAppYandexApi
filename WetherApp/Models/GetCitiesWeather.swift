import Foundation
import CoreLocation

let networkManager = NetworkWeatherManager()

func getCityWeather(citiesArray: [String], completionHandler: @escaping (Int, Weather) -> Void) {
    for (index, city) in citiesArray.enumerated() {
        getCoordinateFrom(city: city) { coordinate, error in
            guard let coordinate = coordinate, error == nil else {
                return
            }

            networkManager.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { weather in
                completionHandler(index, weather)
            }
        }
    }
}

func getCoordinateFrom(
    city: String,
    completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()
) {
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
        completion(placemark?.first?.location?.coordinate, error)
    }
}
