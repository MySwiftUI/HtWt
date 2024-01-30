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

final class HourlyWeatherViewModel: ObservableObject {
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

private extension HourlyWeatherViewModel {
    /// 현재시간보다 이전인지 체크하기 위한 기능
    func checkCurrentTime(
        from sendDate: String
    ) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        return dateFormatter.string(from: Date()) < sendDate
    }
    
    /// 내일모레를 초과하지 않기 위해 체크하는 기능
    func checkTwoDaysLater(
        from sendDate: String
    ) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        return sendDate < dateFormatter.string(from: Calendar.current.date(bySetting: .day, value: 2, of: Date()) ?? Date())
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
            weatherImageName: "clear",
            tempText: ""
        )
        
        for i in 0..<data.count {
            let time = data[i].dtTxt
            if !(checkCurrentTime(from: time) && checkTwoDaysLater(from: time)) { continue }
            
            let uuid: String = String(describing: data[i].weather.first?.id)
            appendData.id = UUID(uuidString: uuid) ?? UUID()
            appendData.timeText = changeFullDateToHourString(from: time)
            appendData.weatherImageName = data[i].weather.first?.icon ?? "clear"
            appendData.tempText = "\(Int(data[i].main.temp))º"
            hourlyWeatherViewItem.append(appendData)
        }
    }
}
