//
//  User.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-11-19.
//

import Foundation

struct User : Codable {
    let id: Int
    let email: String?
    let password: String?
    let username: String?
    let picturePath: String?
}
