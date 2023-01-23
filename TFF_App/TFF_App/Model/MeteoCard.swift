//
//  MeteoCard.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-11-26.
//

import SwiftUI

struct MeteoCard: View {
    var value: String
    var unit: String
    var icon: String
    
    var body: some View {
        HStack {
            Text(Image(systemName: icon))
                .font(Font.system(size: 35))
            
            Text(formatData() + unit)
        }
        .font(.title)
        .padding(25)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        .cornerRadius(10)
        .padding(.vertical, 10)
    }
    
    func formatData() -> String {
        if (value.count > 1) {
            let index = value.index(value.firstIndex(of: ".")!, offsetBy: 2)
            return String(value[..<index])
        }
        return value;
    }
}
