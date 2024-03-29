//
//  HourlyWeatherModel.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/24.
//

import Foundation

struct HourlyWeatherModel: Codable {
    let cod: String
    let message, cnt: Int
    let list: [HourlyWeatherData]
    let city: City
}

/// 지역 관련
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

/// 날씨 리스트
struct HourlyWeatherData: Codable {
    let dt: Int
    let main: MainClass
    let weather: [HourlyWeather]
    let clouds: Clouds
    let wind: HourlyWind
    let visibility: Int
    let pop: Double
    let sys: HourlySys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
    }
}

/// 메인 날씨 정보
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

/// 추가 기상 정보
struct HourlyWeather: Codable {
    let id: Int
    let main, description, icon: String
}

/// Sys
struct HourlySys: Codable {
    let pod: String
}

/// 시간 풍속 정보
struct HourlyWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

/// HourlyWeatherView UI를 위한 커스텀 구조체
struct HourlyWeatherItem: Identifiable {
    var id: UUID
    var timeText: String
    var weatherImageName: String
    var tempText: String
}
