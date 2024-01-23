//
//  MainHeader.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/11.
//

import SwiftUI

struct MainHeader: View {
    @ObservedObject var viewModel = MainHeaderViewModel(
        location: LocationService().getLocation()
    )
    
    var body: some View {
        VStack(alignment: .center) {
            Text(viewModel.locationName ?? "")
                .font(.system(size: 36))
                .fontWeight(.regular)
            
            Text(viewModel.currentTemp ?? "")
                .font(.system(size: 108))
                .fontWeight(.thin)
            
            Text(viewModel.weatherDescription ?? "")
                .font(.system(size: 28))
                .fontWeight(.light)
            
            HStack(spacing: 10) {
                Text(viewModel.maxTemp ?? "")
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                
                Text(viewModel.minTemp ?? "")
                    .font(.system(size: 24))
                    .fontWeight(.medium)
            }
            .padding(-10)
        }
        .foregroundColor(.white)
        .shadow(color: .secondary, radius: 8, x: 2, y: 2)
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 230)
        .background(Color.clear)
    }
}

struct MainHeader_Previews: PreviewProvider {
    static var previews: some View {
        MainHeader()
    }
}
