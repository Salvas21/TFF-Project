//
//  DateHelper.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-11-04.
//

import Foundation
import Time

class DateHelper {
    
    func getDate() -> String {
        let today = (Clock.system).today()
        return formatDate(day: today.day, month: today.month, year: today.year)
    }
    
    private func formatDate(day: Int, month: Int, year: Int) -> String {
        let monthName = getMonthName(month: month)
        return "\(day) \(monthName) \(year)"
    }
    
    private func getMonthName(month: Int) -> String {
        let months = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]
        return months[month-1].uppercased()
    }
}
