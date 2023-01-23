//
//  TripData.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-12-08.
//

import Foundation

class TripData : ObservableObject {
    @Published var hooks: Int
    @Published var touches: Int
    @Published var captures: Int
    var userId: Int
    var tripId: Int
    
    init() {
        hooks = 0
        touches = 0
        captures = 0
        userId = 0
        tripId = 0
    }
}
