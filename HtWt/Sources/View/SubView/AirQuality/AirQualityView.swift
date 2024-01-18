//
//  AirQualityView.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/18.
//

import SwiftUI

struct AirQualityView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .background(.gray)
                .opacity(0.3)
            
            VStack {
                HStack {
                    Image(systemName: "aqi.medium")
                        .resizable()
                        .frame(width: 16, height: 16)
                    
                    Text("대기질")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                    
                    Spacer()
                }
                .padding(.leading, 12)
                .padding(.top, 16)
                .foregroundColor(.white)
                .opacity(0.6)
                
                AirQualitySubView()
                    .padding(.top, -18)
            }
        }
        .cornerRadius(12)
    }
}

struct AirQualityView_Previews: PreviewProvider {
    static var previews: some View {
        AirQualityView()
    }
}
