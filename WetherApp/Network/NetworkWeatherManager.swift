import Foundation

class NetworkWeatherManager {

    func fetchWeather(latitude lat: Double, longitude lon: Double,completionHandler: @escaping (Weather) -> Void) {
        let urlString = "\(APIUrl)/forecast?lat=\(lat)&lon=\(lon)"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue(APIKey, forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            if let weather = self.parseJSON(withData: data) {
                completionHandler(weather)
            }
        }

        task.resume()
    }

    func parseJSON(withData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = Weather(weatherData: weatherData) else {
                return nil
            }
            return weather
        } catch let error as NSError {
            print(error)
        }
        return nil
    }

}

