//
//  DataCard.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-12-08.
//

import SwiftUI

struct DataCard: View {
    var text: String
    var value: Int
    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            Text(text)
                .padding(.bottom, 5)
            Text("\(value)")
                .font(.title)
        })
        .padding(25)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        .cornerRadius(10)
        .padding(.vertical, 10)
    }
}

struct DataCard_Previews: PreviewProvider {
    static var previews: some View {
        DataCard(text: "Nombre de ferrage", value: 2)
    }
}
