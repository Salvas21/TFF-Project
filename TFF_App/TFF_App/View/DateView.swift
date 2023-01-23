//
//  DateView.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-11-04.
//

import SwiftUI

struct DateView: View {
    var date: String
    
    var body: some View {
        HStack {
            Text(Image(systemName: "calendar"))
                .font(Font.system(size: 35))
            Text(date)
                .foregroundColor(Color(red: 103/255, green: 168/255, blue: 160/255, opacity: 1))
                .underline()
        }
        .font(.largeTitle)
        .padding(.vertical, 20)
        .padding(.bottom, 40)
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(date: "21 OCTOBRE 2020")
    }
}
