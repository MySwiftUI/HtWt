//
//  HourlWeatherViewModel.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/24.
//

import Foundation
import Alamofire
import Combine
import CoreLocation

final class MainViewModel: ObservableObject {
    @Published var hourlyWeatherViewItem: [HourlyWeatherItem] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    init(
        location: CLLocationCoordinate2D
    ) {
        requestHourlyWeather(location: location)
    }
    
    private func requestHourlyWeather(
        location: CLLocationCoordinate2D
    ) {
        let param: [String:Any] = [
            "units" : "metric",
            "lang" : "KR",
            "lat" : location.latitude,
            "lon" : location.longitude,
            "appid" : Bundle.main.apiKey
        ]
        
        AF.request(
            Constants.FIVEDAYS_THREEHOURS_URL,
            method: .get,
            parameters: param,
            encoding: URLEncoding.queryString
        )
        .publishDecodable(type: HourlyWeatherModel.self)
        .compactMap { $0.value }
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("DEBUG: reqeustHourlWeather() 서버 통신이 완료되었습니다.")

            case .failure(let error):
                print("DEBUG: requestHourlyWeather() 서버 통신 에러입니다.\n\(error.localizedDescription)")
            }
        }, receiveValue: { response in
            self.hourlyWeatherDataHandler(data: response.list)
        })
        .store(in: &cancellable)
    }
}

private extension MainViewModel {
    /// 현재시간 이전 및 내일모레 초과인지 체크하는 기능
    func compareTime(
        from target: String
    ) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        
        let currentDate = dateFormatter.string(from: Date())
        let threeDaysLaterDate = dateFormatter.string(from: Calendar.current.date(
            byAdding: .day,
            value: 2,
            to: Date()
        ) ?? Date())
        return currentDate < target && target < threeDaysLaterDate
    }
    
    /// 전체 시간을 시간으로만 변환 시켜주는 기능
    func changeFullDateToHourString(
        from fullDate: String
    ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: fullDate) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = Calendar.current.component(.hour, from: date) < 12
            ? "오전 h시"
            : "오후 h시"
            
            return timeFormatter.string(from: date)
        }
        
        else { return "" }
    }
    
    /// HourlyWeatherView에서 필요한 데이터만 핸들링 하는 기능
    func hourlyWeatherDataHandler(
        data: [HourlyWeatherData]
    ) {
        var appendData = HourlyWeatherItem(
            id: UUID(),
            timeText: "",
            weatherImageName: "01d",
            tempText: ""
        )
        
        for i in 0..<data.count {
            let time = data[i].dtTxt
            if !compareTime(from: data[i].dtTxt) { continue }
            
            let uuid: String = String(describing: data[i].weather.first?.id)
            appendData.id = UUID(uuidString: uuid) ?? UUID()
            appendData.timeText = changeFullDateToHourString(from: time)
            appendData.weatherImageName = data[i].weather.first?.icon ?? "01d"
            appendData.tempText = "\(Int(data[i].main.temp))º"
            hourlyWeatherViewItem.append(appendData)
        }
    }
}
