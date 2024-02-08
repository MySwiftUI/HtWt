//
//  DailyWeatherModel.swift
//  HtWt
//
//  Created by 이지석 on 2024/02/08.
//

import Foundation

struct DailyWeatherItem: Identifiable {
    var id: UUID
    var timeText: String
    var weatherImageName: String
    var minTemp: String
    var maxTemp: String
    var currentTemp: String
}
