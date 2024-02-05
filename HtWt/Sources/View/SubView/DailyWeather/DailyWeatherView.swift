//
//  DailyWeatherView.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/16.
//

import SwiftUI

struct DailyWeatherView: View {
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
                    
                    Text("10일간의 일기예보")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                .padding(.top, 16)
                .foregroundColor(.white)
                .opacity(0.6)
                
                ForEach(0..<10) { idx in
                    Divider()
                        .background(.white)
                        .padding(.horizontal, 12)
                    
                    DailyWeatherInfoView(isToday: idx == 0)
                        .padding(.vertical, -12)
                }
            }
            .padding(.bottom, 8)
        }
        .cornerRadius(12)
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView()
    }
}
