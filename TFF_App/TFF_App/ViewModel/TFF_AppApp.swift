//
//  TFF_AppApp.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-10-21.
//

import SwiftUI
import CoreBluetooth

var hello = 2;

@main
struct TFF_AppApp: App {
    var body: some Scene {
        WindowGroup {
            Login()
        }
    }
}


struct TFF_AppApp_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
