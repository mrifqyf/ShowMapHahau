//
//  LocationMOdel.swift
//  Ini Map
//
//  Created by Muhammad Rifqy Fimanditya on 21/05/23.
//

import Foundation
import MapKit

struct LocationModel: Identifiable {
    var id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
    var openHour: Date
    var closedHour: Date
    var image: String
    
    static let locationList = [
        LocationModel(name: "AEON", latitude: -6.304494, longitude: 106.644015, openHour: getDateFromHourFormat(dateString: "09:00"), closedHour: getDateFromHourFormat(dateString: "22:00"), image: "image_aeon_1"),
        LocationModel(name: "The Breeze", latitude: -6.301937, longitude: 106.654243, openHour: getDateFromHourFormat(dateString: "09:00"), closedHour: getDateFromHourFormat(dateString: "21:00"), image: "image_thebreeze_1"),
        LocationModel(name: "QBig BSD City", latitude: -6.283754, longitude: 106.636069, openHour: getDateFromHourFormat(dateString: "10:00"), closedHour: getDateFromHourFormat(dateString: "22:00"), image: "image_qbigbsdcity_1"),
    
    ]
}

func getDateFromHourFormat(dateString: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    let someDateTime = formatter.date(from: dateString)
    return someDateTime ?? Date()
}
