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
    @Published var wData: HourlyWeatherModel?
    
    private var location: CLLocationCoordinate2D
    private lazy var cancellable = Set<AnyCancellable>()
    
    init(
        location: CLLocationCoordinate2D
    ) {
        self.location = location
        requestHourlyWeather()
    }
    
    private func requestHourlyWeather() {
        print("DEBUG: requestHourlyWeather() --- ")
        let param: [String:Any] = [
            "units" : "metric",
            "lang" : "KR",
            "lat" : location.latitude,
            "lon" : location.longitude,
            "appid" : Bundle.main.apiKey
        ]
        
//        AF.request(
//            Constants.FIVEDAYS_THREEHOURS_URL,
//            method: .get,
//            parameters: param,
//            encoding: URLEncoding.queryString
//        )
//        .publishDecodable(type: HourlyWeatherModel.self)
//        .compactMap { $0.value }
//        .sink(receiveCompletion: { _ in
//            print("DEBUG: requestHourlyWeather() 실행이 완료되었습니다.")
//        }, receiveValue: { response in
//            print("DEBUG: response is \(response)")
//        })
//        .store(in: &cancellables)

        AF.request(
            Constants.FIVEDAYS_THREEHOURS_URL,
            method: .get,
            parameters: param,
            encoding: URLEncoding.queryString
        )
        .responseDecodable(of: HourlyWeatherModel.self) { response in
            print("DEBUG: response is \(response.value)")
        }
    }
}
