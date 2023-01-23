//
//  UserId.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-12-09.
//

import Foundation

class UserId: ObservableObject {
    @Published var id: Int
    
    init() {
        id = 0
    }
}
