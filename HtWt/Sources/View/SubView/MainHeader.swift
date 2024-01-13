//
//  MainHeader.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/11.
//

import SwiftUI

struct MainHeader: View {
    @State var locationName: String
    @State var currentTemp: String
    @State var weatherInfo: String
    @State var maxTemp: String
    @State var minTemp: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(locationName)
                .font(.system(size: 32))
                .fontWeight(.regular)
            
            Text(currentTemp)
                .font(.system(size: 84))
                .fontWeight(.light)
            
            Text(weatherInfo)
                .font(.system(size: 22))
                .fontWeight(.light)
            
            HStack(spacing: 10) {
                Text(maxTemp)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                
                Text(minTemp)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
            }
            .padding(-10)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 230)
        .background(Color.clear)
    }
}

struct MainHeader_Previews: PreviewProvider {
    static var previews: some View {
        MainHeader(
            locationName: "서울시",
            currentTemp: "5º",
            weatherInfo: "대체로 흐림",
            maxTemp: "5º",
            minTemp: "-5º"
        )
    }
}
