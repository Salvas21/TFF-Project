//
//  WeatherView.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-11-04.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var meteoData: MeteoData
    
    var body: some View {
        VStack {
            DateView(date: DateHelper().getDate())
            VStack {
                MeteoCard(value: meteoData.temperature, unit: " ℃",  icon: "thermometer")
                MeteoCard(value: meteoData.humidity, unit: " %", icon: "drop")
                MeteoCard(value: meteoData.pressure, unit: " kPa", icon: "barometer")
                MeteoCard(value: meteoData.wind, unit: " km/h", icon: "wind")
                // https://www.btb.termiumplus.gc.ca/tpv2guides/guides/wrtps/index-eng.html?lang=eng&lettr=indx_catlog_k&page=97ceyqFEvTJY.html
            }
            .padding(.horizontal, 40)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .accentColor(Color(red: 103/255, green: 168/255, blue: 160/255, opacity: 1))
        }
    }
    
}
