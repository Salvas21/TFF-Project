//
//  HubView.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-11-04.
//

import SwiftUI
import CoreBluetooth

struct HubView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var btConnector = BluetoothConnector()
    @State private var peripheral: CBPeripheral?
    @State private var locationHelper = LocationHelper()
    @ObservedObject private var btComm = BluetoothCommunicator()
    @ObservedObject var userId: UserId
        
    var body: some View {
        TabView {
            HomeView(btConnector: $btConnector, btComm: btComm, userId: self.userId)
                .tabItem {
                    Image(uiImage: UIImage(systemName: "house.fill")!)
                    Text("Accueil")
                }
            WeatherView(meteoData: self.btComm.meteoData)
                .tabItem {
                    Image(uiImage: UIImage(systemName: "cloud.fill")!)
                    Text("Météo")
                }
            DataView(tripData: self.btComm.tripData, btComm: btComm)
                .tabItem {
                    Image(uiImage: UIImage(systemName: "antenna.radiowaves.left.and.right")!)
                    Text("Données pêche")
                }
            CatchView(btComm: btComm)
                .tabItem {
                    Image(uiImage: UIImage(systemName: "doc.richtext")!)
                    // doc.richtext // .fill
                    // bookmark // bookmark.circle // .fill
                    Text("Capture")
                }
        }
        .accentColor(Color(red: 103/255, green: 168/255, blue: 160/255, opacity: 1))
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
}
