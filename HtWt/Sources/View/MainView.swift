//
//  ContentView.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/11.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Image("bgClear")
                .resizable()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                LazyVStack() {
                    MainHeader(
                        locationName: "서울시",
                        currentTemp: "5º",
                        weatherInfo: "맑음",
                        maxTemp: "최고:5º",
                        minTemp: "최저:-5º"
                    )
                    .padding(.top, 54)
                    .padding(.bottom, 78)
                    
                    HourlyWeatherView(
                        descriptionText: "오늘 날씨는 맑습니다",
                        timeText: "9시",
                        weatherImageName: "clear",
                        tempText: "-5º"
                    )
                    
                    DailyWeatherView()
                        .padding(.top, 12)
                    
                    AirQualityView()
                        .padding(.vertical, 12)
                }
                .padding(.horizontal, 16)
            }
            .clipped()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
