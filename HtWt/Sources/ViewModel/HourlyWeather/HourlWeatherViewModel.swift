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
    @Published var hourlyWeatherData: [HourlyWeatherData] = []
    
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
            self.hourlyWeatherData = Array(response.list.prefix(24))
        })
        .store(in: &cancellable)
    }
}
