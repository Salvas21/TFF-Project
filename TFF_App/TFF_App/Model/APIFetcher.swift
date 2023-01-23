//
//  APIFetcher.swift
//  TFF_App
//
//  Created by Mickael Salvas on 2020-11-19.
//

import Foundation
import CoreLocation
import Alamofire

final class APIFetcher {
    
    private let baseUrl = "http://tff.sexy/api/"
    
    func fetchAuthentication(email: String, password: String, completionHandler: @escaping (User) -> Void) {
        let url = URL(string: baseUrl + "authenticate")!
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30
        request.httpBody = parameters.percentEncoded()
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
            if let data = data, let user = try? JSONDecoder().decode(User.self, from: data) {
                completionHandler(user)
            }
        }.resume()
    }
    
    func fetchWind(coordinate: CLLocationCoordinate2D, completionHandler: @escaping (WindInfo) -> Void) {
        let url = URL(string: baseUrl + "fetch-wind-data")!
        let parameters: [String: Any] = [
            "lat": coordinate.latitude,
            "lon": coordinate.longitude
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30
        request.httpBody = parameters.percentEncoded()
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
            if let data = data, let windInfo = try? JSONDecoder().decode(WindInfo.self, from: data) {
                completionHandler(windInfo)
            }
        }.resume()
    }
    
    func postNewTrip(id: Int, completionHandler: @escaping (Int) -> Void) {
        let url = URL(string: baseUrl + "trip")!
        let parameters: [String: Any] = [
            "userId": id
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30
        request.httpBody = parameters.percentEncoded()
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
            if let data = data, let tripId = try? JSONDecoder().decode(Int.self, from: data) {
                completionHandler(tripId)
            }
        }.resume()
    }
    
    func endTrip(tripId: Int, hooks: Int, touches: Int, completionHandler: @escaping (Int) -> Void) {
        let url = URL(string: baseUrl + "end-trip")!
        let parameters: [String: Any] = [
            "tripId": tripId,
            "hooks": hooks,
            "bites": touches
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30
        request.httpBody = parameters.percentEncoded()
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//            if let data = data, let tripId = try? JSONDecoder().decode(Int.self, from: data) {
//                completionHandler(tripId)
//            }
            completionHandler(1)
        }.resume()
    }
    
    
    func sendCatch(tripData: TripData, meteoData: MeteoData, coordinates: CLLocationCoordinate2D, specie: String, weight: String, image: Data, completionHandler: @escaping (Int) -> Void) {
        let url = URL(string: baseUrl + "catch")!
        
        let parameters: [String : Any] = [
            "tripId": tripData.tripId,
            "temperature": meteoData.temperature,
            "pressure": meteoData.pressure,
            "humidity": meteoData.humidity,
            "wind": meteoData.wind,
            "longitude": coordinates.longitude,
            "latitude": coordinates.latitude,
            "species": specie,
            "weight": weight,
        ]
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        let fileName = randomString(length: 10) + ".jpg"
        
        AF.upload(multipartFormData: { multipartFormData in
                
            multipartFormData.append(image, withName: "file", fileName: fileName, mimeType: "image/jpeg")
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
//                if let data = value as? Data {
//                    multipartFormData.append(data, withName: key)
//                }
            }
            print(multipartFormData)
            }, to: url, method: .post, headers: headers)
                .responseJSON(completionHandler: { (response) in
                    completionHandler(1)
                })
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

// https://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method/26365148#26365148
extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
