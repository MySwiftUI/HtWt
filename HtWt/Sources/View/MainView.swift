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
                    MainHeader()
                    .padding(.top, 54)
                    .padding(.bottom, 78)
                    
                    HourlyWeatherView()
                    
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
