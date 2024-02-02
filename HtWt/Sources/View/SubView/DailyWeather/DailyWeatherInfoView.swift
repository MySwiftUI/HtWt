//
//  DailyWeatherView.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/16.
//

import SwiftUI

struct DailyWeatherInfoView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .background(.clear)
                .opacity(0)
            
            HStack(spacing: 42) {
                Text("오늘")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Image("01d")
                    .resizable()
                    .frame(width: 32, height: 32)
                
                HStack(spacing: 8) {
                    Text("-8º")
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
                                .frame(width: 80)   /// 10일 중 최저와 최대로 나누어 양 끝도 빌 수 있음
                                .offset(x: 10)      /// offset X 잡아줘야 할 것으로 보임
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
                    
                    Text("3º")
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
}

struct DailyWeatherInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherInfoView()
    }
}
