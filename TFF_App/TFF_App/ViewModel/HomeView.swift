//
//  HomeView.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-10-28.
//

import SwiftUI
import CoreBluetooth
import CoreLocation
import MapKit

// https://stackoverflow.com/a/60810241
struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text?
    var dismissButton: Alert.Button?
}

struct HomeView: View {
    @State private var alertItem: AlertItem?
    @Binding var btConnector: BluetoothConnector
    @ObservedObject var btComm: BluetoothCommunicator
    @ObservedObject var userId: UserId
    
    var body: some View {
        VStack {
            Button("Se connecter à l'appareil BLE TFF") {
                if (btConnector.isConnected()) {
                    btComm.setUserId(userId: self.userId.id)
                }
                showConnectionMsg()
            }
            .font(.title2)
            MapView()
            Button("Commencer un nouveau voyage") {
                if (btComm.tripData.userId != 0) {
                    btComm.createTrip(id: userId.id)
                    showTripMessage()
                }
            }
            .foregroundColor(.white)
            .font(.title3)
            .padding()
            .background(Color(red: 103/255, green: 168/255, blue: 160/255, opacity: 1))
            .cornerRadius(10)
            .padding(.top, 10)
            .padding(.bottom, 25)
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .accentColor(Color(red: 103/255, green: 168/255, blue: 160/255, opacity: 1))
        .alert(item: $alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
    
    func showConnectionMsg() {
        if btConnector.isConnected() {
            alertItem = AlertItem(title: Text("Succès"), message: Text("Vous êtes connectés à l'appareil BLE TFF."), dismissButton: .default(Text("OK")))
        } else {
            alertItem = AlertItem(title: Text("Erreur"), message: Text("Appareil BLE TFF introuvable."), dismissButton: .default(Text("OK")))
        }
    }
    
    func showTripMessage() {
        alertItem = AlertItem(title: Text("Succès"), message: Text("Voyage de pêche commencé."), dismissButton: .default(Text("OK")))
    }
}
