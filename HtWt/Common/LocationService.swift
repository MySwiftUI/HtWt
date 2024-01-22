//
//  LocationService.swift
//  HtWt
//
//  Created by 이지석 on 2024/01/22.
//

import Foundation
import CoreLocation

final class LocationService:
    NSObject,
    CLLocationManagerDelegate
{
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func getLocation() -> CLLocationCoordinate2D {
        return manager.location?.coordinate ?? CLLocationCoordinate2D()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("DEBUG: LocationService()에서 위치 정보를 가져오는데 실패했습니다.\n\(error.localizedDescription)")
    }
}
