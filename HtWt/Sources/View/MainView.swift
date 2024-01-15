//
//  ContentView.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/11.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ScrollView {
            LazyVStack() {
                MainHeader(
                    locationName: "서울시",
                    currentTemp: "5º",
                    weatherInfo: "대체로 흐림",
                    maxTemp: "5º",
                    minTemp: "-5º"
                )
                
                HourlyWeatherView(
                    descriptionText: "오늘 날씨는 맑습니다.",
                    timeText: "9시",
                    weatherImageName: "clear",
                    tempText: "-5º"
                )
            }
            .padding()
        }
        .clipped()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
