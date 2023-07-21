//
//  NavigateViewModel.swift
//  Ini Map
//
//  Created by Muhammad Rifqy Fimanditya on 24/05/23.
//

import Foundation
import CoreLocation

final class NavigateViewModel: ObservableObject{
    @Published var title: String?
    @Published var info: String?
    @Published var isShown = false
    
    @Published var routes = [
        LocationModel(name: "AEON", latitude: -6.304494, longitude: 106.644015, openHour: getDateFromHourFormat(dateString: "09:00"), closedHour: getDateFromHourFormat(dateString: "22:00"), image: "image_aeon_1"),
        LocationModel(name: "The Breeze", latitude: -6.301937, longitude: 106.654243, openHour: getDateFromHourFormat(dateString: "09:00"), closedHour: getDateFromHourFormat(dateString: "21:00"), image: "image_thebreeze_1"),
        LocationModel(name: "QBig BSD City", latitude: -6.283754, longitude: 106.636069, openHour: getDateFromHourFormat(dateString: "10:00"), closedHour: getDateFromHourFormat(dateString: "22:00"), image: "image_qbigbsdcity_1")
    ]
    //variable2
    
    func openSheet(selectedTitle: String, selectedInfo: String){
        title = selectedTitle
        info = selectedInfo
        isShown = true
    }
}
