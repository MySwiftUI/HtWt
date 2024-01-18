//
//  AirQualitySubView.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/18.
//

import SwiftUI

struct AirQualitySubView: View {
    // FIXME: - Binding으로 바꿀 예정, UI 작업 임시 변수
    @State private var headerText: String = "61 - 보통"
    @State private var descriptionText: String = "현재의 대기질 지수는 61 수준으로, 어제 이 시간과 비슷합니다."
    @State private var airQualityLevel: Float = 61
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(.clear)
                .opacity(0)
            
            VStack(
                alignment: .leading,
                spacing: 8
            ) {
                Text(headerText)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                
                Text(descriptionText)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                
                ZStack {
                    GeometryReader { proxy in
                        Capsule()
                            .fill(.linearGradient(
                                Gradient(colors: [.blue, .green, .yellow, .orange, .red]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.horizontal, 4)
                    }
                    
                    Circle()
                        .foregroundColor(.white)
                        .overlay(Circle()
                            .stroke(lineWidth: 3)
                            .foregroundColor(.black).opacity(0.2)
                        )
                        .frame(width: 5, height: 5)
                        .offset(x: -CGFloat(airQualityLevel)-251.0 / UIScreen.main.bounds.width)
                    /// 현재 대기질 표시(offset x 위치 조정)
                }
                .frame(height: 5)
                .padding(.top, 16)
            }
            .foregroundColor(.white)
            .padding()
        }
    }
}

struct AirQualitySubView_Previews: PreviewProvider {
    static var previews: some View {
        AirQualitySubView()
    }
}
