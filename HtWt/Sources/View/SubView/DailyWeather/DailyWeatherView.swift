//
//  DailyWeatherView.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/16.
//

import SwiftUI

struct DailyWeatherView: View {
    @ObservedObject var viewModel: DailyWeatherViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(.gray)
                .opacity(0.3)
            
            LazyVStack {
                HStack {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .padding(.leading, 12)
                    
                    Text("5일간의 일기예보")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                .padding(.top, 16)
                .foregroundColor(.white)
                .opacity(0.6)
                
                ForEach(viewModel.dailyWeatherViewItem) { item in
                    Divider()
                        .background(.white)
                        .padding(.horizontal, 12)
                    
                    DailyWeatherInfoView(dailyWeatherItem: item)
                        .padding(.vertical, -12)
                }
            }
            .padding(.bottom, 8)
        }
        .cornerRadius(12)
    }
}
