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

// MARK: - GeometryReader width/offset 등 UI 관련 기능
extension DailyWeatherViewModel {
    func calculateWidth(
        maxTemp: Double,
        highestTemp: Double,
        minTemp: Double,
        lowestTemp: Double
    ) -> CGFloat {
        // FIXME: - API 오류로 minTemp, maxTemp가 같은 값으로 오는 중이라 임시 guard문
        guard maxTemp == minTemp else {
            let overall = abs(highestTemp) + abs(lowestTemp)
            let gap = (abs(highestTemp) - abs(maxTemp)) + (abs(lowestTemp) - abs(minTemp))
            return 100 * (abs(overall) - abs(gap)) / overall
        }
        return 10
    }
    
    func calculateOffset(
        minTemp: Double,
        lowestTemp: Double,
        highestTemp: Double
    ) -> CGFloat {
        let overall = abs(highestTemp) + abs(lowestTemp)
        let gap = abs(abs(lowestTemp) - abs(minTemp))
        return 100 * gap / overall
    }
}
 

// MARK: - 5일간 날씨 응답값 핸들링 관련한 기능들
private extension DailyWeatherViewModel {
    /// DailyWeatherView에서 필요한 데이터만 핸들링 하는 기능
    func dailyWeatherDataHandler(
        data: [HourlyWeatherData]
    ) {
        var lowestTemp: Double = 0.0
        var highestTemp: Double = 0.0
        var appendData = DailyWeatherItem(
            id: UUID(),
            timeText: "",
            weatherImageName: "01d",
            currentTemp: "",
            minTemp: 0.0,
            maxTemp: 0.0,
            lowestTemp: lowestTemp,
            highestTemp: highestTemp
        )
        
        for i in 0..<data.count {
            let time = data[i].dtTxt
            if i == 0 || findFirstIndexItem(date: time) {
                let uuid: String = String(describing: data[i].weather.first?.id)
                appendData.id = UUID(uuidString: uuid) ?? UUID()
                appendData.timeText = i == 0 ? "오늘" : changeFullDateToDayString(from: time)
                appendData.weatherImageName = data[i].weather.first?.icon ?? "01d"
                appendData.currentTemp = "\(Int(data[i].main.temp))º"
                appendData.minTemp = data[i].main.tempMin
                appendData.maxTemp = data[i].main.tempMax
                
                lowestTemp = min(lowestTemp, data[i].main.tempMin)
                highestTemp = max(highestTemp, data[i].main.tempMax)
                appendData.lowestTemp = lowestTemp
                appendData.highestTemp = highestTemp
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
