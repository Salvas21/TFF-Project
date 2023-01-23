//
//  DataView.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-12-08.
//

import SwiftUI

struct DataView: View {
    @ObservedObject var tripData: TripData
    @ObservedObject var btComm: BluetoothCommunicator
    @State private var endTripAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            Button("Réinitialiser les données") {
                btComm.resetTripData()
            }
            DataCard(text: "Nombre de ferrages", value: tripData.hooks)
            DataCard(text: "Nombre de touches", value: tripData.touches)
            DataCard(text: "Nombre de captures", value: tripData.captures)
            Button("Terminer le voyage") {
                if (tripData.tripId != 0) {
                    DispatchQueue.main.async {
                        APIFetcher().endTrip(tripId: tripData.tripId, hooks: tripData.hooks, touches: tripData.touches, completionHandler: { (resultCode) in
                            DispatchQueue.main.async {
                                endTripAlert.toggle()
                            }
                        })
                    }
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
        .padding(.horizontal, 40)
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .accentColor(Color(red: 103/255, green: 168/255, blue: 160/255, opacity: 1))
        .alert(isPresented: $endTripAlert, content: {
            Alert(title: Text("Succès"), message: Text("Votre voyage a bien été terminé."), dismissButton: .default(Text("OK")))
        })
    }
}
