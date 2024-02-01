//
//  HourlyWeatherView.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/13.
//

import SwiftUI

struct HourlyWeatherView: View {
    // FIXME: - 추후 서버 통신하게 되면 넣어둘 예정입니다. 임의로 State로 UI 작업을 위해 주석처리 해두었습니다.
//    @Binding var descriptionText: String
//    @Binding var timeText: String
//    @Binding var weatherImageName: String
//    @Binding var tempText: String
    
    @State var descriptionText: String
    @State var timeText: String
    @State var weatherImageName: String
    @State var tempText: String
    
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
                
                // FIXME: - 20개 임의로 넣어뒀습니다. 추후 서버 데이터 받아오면 데이터 개수로 바뀔 예정입니다.
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
        HourlyWeatherView(
            descriptionText: "오늘 날씨는 맑습니다.",
            timeText: "9시",
            weatherImageName: "clear",
            tempText: "-5º"
        )
    }
}
