//
//  BluetoothCommunicator.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-11-18.
//

import Foundation
import CoreBluetooth
import CoreLocation

class BluetoothCommunicator : NSObject, CBPeripheralManagerDelegate, ObservableObject {
    var peripheralManager: CBPeripheralManager?
    static let instance = BluetoothCommunicator()
    @Published var meteoData: MeteoData = MeteoData()
    @Published var tripData: TripData = TripData()
    var locationHelper: LocationHelper = LocationHelper()
    
    override init() {
        super.init()
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        readIncomingData()
        readWindData();
    }
    
    func updateMeteoData() {
        let oldMeteo = self.meteoData
        self.meteoData = oldMeteo
    }
    
    func updateTripData() {
        let oldTrip = self.tripData
        self.tripData = oldTrip
    }
    
    func setUserId(userId: Int) {
        self.tripData.userId = userId
        print(self.tripData.userId)
    }
    
    func resetTripData() {
        self.tripData.captures = 0
        self.tripData.hooks = 0
        self.tripData.touches = 0
        updateTripData()
    }
    
    func addCatch() {
        self.tripData.captures += 1
        updateTripData()
    }
    
    func readIncomingData() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Notify"), object: nil , queue: nil) {
            notification in
            let incoming = characteristicASCIIValue
            var data = ""
            
            if (incoming.contains("<temperature>")) {
                let temperatureRange: NSRange = incoming.range(of: "<temperature>")
                data = String(incoming.substring(to: temperatureRange.lowerBound))
                self.meteoData.temperature = data
                self.updateMeteoData()
                
            } else if (incoming.contains("<pressure>")) {
                let pressureRange: NSRange = incoming.range(of: "<pressure>")
                data = String(incoming.substring(to: pressureRange.lowerBound))
                self.meteoData.pressure = data
                self.updateMeteoData()
                
            } else if (incoming.contains("<humidity>")) {
                let humidityRange: NSRange = incoming.range(of: "<humidity>")
                data = String(incoming.substring(to: humidityRange.lowerBound))
                self.meteoData.humidity = data
                self.updateMeteoData()
                
            } else if (incoming.contains("<hook>")) {
                self.tripData.hooks += 1
                self.updateTripData()
                
            } else if (incoming.contains("<vibration>")) {
                self.tripData.touches += 1
                self.updateTripData()
                
            }
        }
    }
    
    func readWindData() {
        DispatchQueue.main.async {
            APIFetcher().fetchWind(coordinate: self.locationHelper.location?.coordinate ?? CLLocationCoordinate2D(), completionHandler: { (windInfo) in
                DispatchQueue.main.async {
                    self.meteoData.wind = windInfo.value ?? "0"
                    self.updateMeteoData()
                }
            })
        }
        
    }
    
    func createTrip(id: Int) {
        resetTripData();
        DispatchQueue.main.async {
            APIFetcher().postNewTrip(id: id, completionHandler: { (tripId) in
                DispatchQueue.main.async {
                    self.tripData.tripId = tripId
                    print(self.tripData.tripId)
                }
            })
        }
    }
    
    func getLocationCoordinate() -> CLLocationCoordinate2D {
        return self.locationHelper.location!.coordinate
    }
    
    // Write functions
    func writeValue(data: String) {
        // binary conversion ?
        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
        if let blePeripheral = blePeripheral{
            if let txCharacteristic = txCharacteristic {
                blePeripheral.writeValue(valueString!, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
            }
        }
    }
    
    func writeCharacteristic(val: Int8){
        var val = val
        let ns = NSData(bytes: &val, length: MemoryLayout<Int8>.size)
        blePeripheral!.writeValue(ns as Data, for: txCharacteristic!, type: CBCharacteristicWriteType.withResponse)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            return
        }
    }
    
    //Check when someone subscribe to our characteristic, start sending the data
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("Device subscribe to characteristic")
    }
        
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            print("\(error)")
            return
        }
    }
}
