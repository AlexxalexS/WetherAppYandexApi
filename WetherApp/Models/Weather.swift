import Foundation

struct Weather: Decodable, Equatable {

    var name: String = "Name"
    var temp: Double
    var conditionCode: String
    var url: String
    var condition: String
    var windSpeed: Double
    var pressureMm: Double
    let tempMin: Double
    let tempMax: Double

    var conditionString: String {
        switch condition {
        case "clear": return "Ясно"
        case "partly-cloudy": return "малооблачно"
        case "cloudy": return "облачно с прояснениями"
        case "overcast": return "пасмурно"
        case "drizzle": return "морось"
        case "light-rain": return "небольшой дождь"
        case "rain": return "дождь"
        case "moderate-rain": return "умеренно сильный дождь"
        case "heavy-rain": return "сильный дождь"
        case "continuous-heavy-rain ": return "длительный сильный дождь"
        case "showers": return "ливень"
        case "wet-snow": return "дождь со снегом"
        case "light-snow": return "небольшой снег"
        case "snow": return "снег"
        case "snow-showers": return "снегопад"
        case "hail": return "град"
        case "thunderstorm": return "гроза"
        case "thunderstorm-with-rain": return "дождь с грозой"
        case "thunderstorm-with-hail": return "гроза с градом"
        default: return "Загрузкаю..."
        }
    }

    init?(weatherData data: WeatherData) {
        name = ""
        temp = data.fact?.temp ?? 0.0
        conditionCode = data.fact?.icon ?? ""
        url = data.info?.url ?? ""
        condition = data.fact?.condition ?? ""
        windSpeed = data.fact?.windSpeed ?? 0.0
        pressureMm = data.fact?.pressureMm ?? 0.0
        tempMin = data.forecasts?.first?.parts?.day?.tempMin ?? 0.0
        tempMax = data.forecasts?.first?.parts?.day?.tempMax ?? 0.0
    }

}
