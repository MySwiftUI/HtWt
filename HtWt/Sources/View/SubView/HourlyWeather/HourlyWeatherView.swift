//
//  HourlyWeatherView.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/13.
//

import SwiftUI

struct HourlyWeatherView: View {
    @ObservedObject var viewModel = HourlyWeatherViewModel(
        location: LocationService().getLocation()
    )
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(.gray)
                .opacity(0.3)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .frame(width: 16, height: 16)
                    
                    Text("시간별 일기 예보")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .opacity(0.6)
                .padding([.top, .leading], 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.hourlyWeatherViewItem) { item in
                            VStack {
                                Text(item.timeText)
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Image(item.weatherImageName)
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                
                                Text(item.tempText)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 4)
                            .padding(.top, -8)
                            .padding(.bottom, 4)
                        }
                    }
                    .frame(height: 110)
                }
                .padding(.top, -2)
                .padding(.bottom, 4)
                .padding(.horizontal, 8)
            }
        }
        .cornerRadius(12)
    }
}

struct HourlyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyWeatherView()
    }
}
