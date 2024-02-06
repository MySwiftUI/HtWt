//
//  HtWtApp.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/11.
//

import SwiftUI

@main
struct HtWtApp: App {
    private let viewModel = MainViewModel(
        location: LocationService().getLocation()
    )
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
        }
    }
}
