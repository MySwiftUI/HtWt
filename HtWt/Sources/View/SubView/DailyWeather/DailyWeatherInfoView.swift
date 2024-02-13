//
//  DailyWeatherView.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/16.
//

import SwiftUI

struct DailyWeatherInfoView: View {
    @State var dailyWeatherItem: DailyWeatherItem
    @State var geoWidth: CGFloat
    @State var geoOffset: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(.clear)
                .opacity(0)
            
            HStack(spacing: 42) {
                Text(dailyWeatherItem.timeText)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Image(dailyWeatherItem.weatherImageName)
                    .resizable()
                    .frame(width: 32, height: 32)
                
                HStack(spacing: 8) {
                    Text("\(Int(dailyWeatherItem.minTemp))º")
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.4)
                    
                    ZStack {
                        Capsule()
                            .foregroundColor(.black)
                            .opacity(0.1)
                        
                        GeometryReader { proxy in
                            Capsule()
                                .fill(.linearGradient(
                                    Gradient(colors: [.blue, .green, .yellow]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ))
                                .frame(width: geoWidth)
                                .offset(x: geoOffset)
                        }
                        
                        Circle()
                            .foregroundColor(.white)
                            .overlay(Circle()
                                .stroke(lineWidth: 3)
                                .foregroundColor(.black).opacity(0.2)
                            )
                            .frame(width: 5, height: 5)
                            .offset(x: -15)         /// 현재 온도 표시(offset x 위치 조정)
                    }
                    .frame(height: 5)
                    
                    Text("\(Int(dailyWeatherItem.maxTemp))º")
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
}
