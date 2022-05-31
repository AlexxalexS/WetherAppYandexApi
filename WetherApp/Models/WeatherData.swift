import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let info: Info?
    let fact: Fact?
    let forecasts: [Forecast]?
}

// MARK: - Fact
struct Fact: Codable {
    let temp: Double?
    let icon: String?
    let condition: String?
    let windSpeed: Double?
    let pressureMm: Double?


    enum CodingKeys: String, CodingKey {
        case temp, icon, condition
        case windSpeed = "wind_speed"
        case pressureMm = "pressure_mm"
    }
}

enum Condition: String, Codable {
    case cloudy = "cloudy"
    case lightRain = "light-rain"
    case overcast = "overcast"
    case rain = "rain"
}

enum Daytime: String, Codable {
    case d = "d"
    case n = "n"
}

enum Icon: String, Codable {
    case bknD = "bkn_d"
    case bknN = "bkn_n"
    case bknRaD = "bkn_-ra_d"
    case iconOvcRa = "ovc_ra"
    case ovc = "ovc"
    case ovcRa = "ovc_-ra"
}

enum WindDir: String, Codable {
    case e = "e"
    case n = "n"
    case ne = "ne"
    case nw = "nw"
    case s = "s"
    case se = "se"
    case sw = "sw"
    case w = "w"
}

// MARK: - Forecast
struct Forecast: Codable {
    let parts: Parts?
}

// MARK: - Biomet
struct Biomet: Codable {
    let index: Double?
    let condition: String?
}

// MARK: - Hour
struct Day: Codable {

    let tempMin, tempMax: Double?

    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }

}

// MARK: - Parts
struct Parts: Codable {
    let day: Day?
}

// MARK: - GeoObject
struct GeoObject: Codable {
    let district, locality, province, country: Country?
}

// MARK: - Country
struct Country: Codable {
    let id: Double?
    let name: String?
}

// MARK: - Info
struct Info: Codable {
    let url: String?
}

// MARK: - Tzinfo
struct Tzinfo: Codable {
    let name, abbr: String?
    let dst: Bool?
    let offset: Double?
}

// MARK: - Yesterday
struct Yesterday: Codable {
    let temp: Double?
}
