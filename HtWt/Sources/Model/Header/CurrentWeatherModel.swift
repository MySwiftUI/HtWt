//
//  CurrentWeatherModel.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/20.
//

import Foundation

struct SearchPostsResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

/// 흐림 퍼센트
struct Clouds: Codable {
    let all: Int
}

/// 좌표
struct Coord: Codable {
    let lon, lat: Double
}

/// 기본 정보들
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

//// 일출, 일몰 시간
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

/// 추가 기상 정보
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

/// 바람 관련 정보
struct Wind: Codable {
    let speed: Double
    let deg: Int
}
