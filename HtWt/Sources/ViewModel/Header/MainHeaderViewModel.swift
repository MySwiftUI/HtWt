//
//  MainHeaderViewModel.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/20.
//

import SwiftUI
import Alamofire
import CoreLocation
import Combine

final class MainHeaderViewModel: ObservableObject {
    @Published var locationName: String?
    @Published var currentTemp: String?
    @Published var weatherDescription: String?
    @Published var maxTemp: String?
    @Published var minTemp: String?
    
    private var location: CLLocationCoordinate2D
    private lazy var cancellable = Set<AnyCancellable>()
    
    init(
        location: CLLocationCoordinate2D
    ) {
        self.location = location
        requestCurrentWeather()
    }
    
    private func requestCurrentWeather() {
        let param : [String:Any] = [
            "units" : "metric",
            "lang" : "KR",
            "lat" : location.latitude,
            "lon" : location.longitude,
            "appid" : Bundle.main.apiKey
        ]
        
        AF.request(
            Constants.BASE_URL + Constants.CURRENT_PATH,
            method: .get,
            parameters: param,
            encoding: URLEncoding.queryString
        )
        .publishDecodable(type: CurrentWeatherModel.self)
        .compactMap { $0.value }
        .sink(receiveCompletion: { _ in
            print("DEBUG: requestCurrentWeather() 실행이 완료되었습니다.")
        }, receiveValue: { response in
            self.viewDataHandler(data: response)
        })
        .store(in: &cancellable)
    }
    
    private func viewDataHandler(
        data: CurrentWeatherModel
    ) {
        locationName = data.name
        currentTemp = "\(Int(data.main.temp))"
        weatherDescription = data.weather.first?.description
        maxTemp = "최고:\(Int(data.main.tempMax))º"
        minTemp = "최저:\(Int(data.main.tempMin))º"
    }
}
