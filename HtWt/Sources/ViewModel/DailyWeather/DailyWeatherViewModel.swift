//
//  DailyWeatherViewModel.swift
//  HtWt
//
//  Created by 이지석 on 2024/02/08.
//

import Foundation

final class DailyWeatherViewModel: ObservableObject {
    @Published var dailyWeatherViewItem: [DailyWeatherItem] = []
    
    init(
        data: [HourlyWeatherData]
    ) {
        dailyWeatherDataHandler(data: data)
    }
}
 
private extension DailyWeatherViewModel {
    /// DailyWeatherView에서 필요한 데이터만 핸들링 하는 기능
    func dailyWeatherDataHandler(
        data: [HourlyWeatherData]
    ) {
        var appendData = DailyWeatherItem(
            id: UUID(),
            timeText: "",
            weatherImageName: "01d",
            minTemp: "",
            maxTemp: "",
            currentTemp: ""
        )
        
        for i in 0..<data.count {
            let time = data[i].dtTxt
            if i == 0 || findFirstIndexItem(date: time) {
                let uuid: String = String(describing: data[i].weather.first?.id)
                appendData.id = UUID(uuidString: uuid) ?? UUID()
                appendData.timeText = i == 0 ? "오늘" : changeFullDateToDayString(from: time)
                appendData.weatherImageName = data[i].weather.first?.icon ?? "01d"
                appendData.currentTemp = "\(Int(data[i].main.temp))º"
                appendData.minTemp = "\(Int(data[i].main.tempMin))º"
                appendData.maxTemp = "\(Int(data[i].main.tempMax))º"
                dailyWeatherViewItem.append(appendData)
            }
        }
    }
    
    /// 각 날짜 중 첫번재(00시) 날씨 데이터 가져오는 기능
    func findFirstIndexItem(
        date: String
    ) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        
        if let timeDate = dateFormatter.date(from: date) {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: timeDate)
            return hour == 0
        }
        
        return false
    }
    
    /// 일별 날씨 노출을 위한 "요일" 추출하는 기능
    func changeFullDateToDayString(
        from fullDate: String
    ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: fullDate) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEEE"
            return dayFormatter.string(from: date)
        }
        
        else { return "" }
    }
}
