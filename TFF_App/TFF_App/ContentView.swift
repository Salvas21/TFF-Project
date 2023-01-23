//
//  ContentView.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-10-21.
//

import SwiftUI

struct ContentView: View {
    var value: String?
    var body: some View {
        Text(value ?? "Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
