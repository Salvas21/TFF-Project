//
//  MeteoData.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-11-26.
//

import Foundation

class MeteoData : ObservableObject {
    @Published var temperature: String
    @Published var pressure: String
    @Published var humidity: String
    @Published var wind: String
    
    init() {
        temperature = "0"
        pressure = "0"
        humidity = "0"
        wind = "0"
    }
}
