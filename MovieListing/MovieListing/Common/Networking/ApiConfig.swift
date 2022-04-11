//
//  ApiConfig.swift
//  Nimbus
//
//  Created by CVN on 16/05/20.
//  Copyright © 2020 Raj. All rights reserved.
//

import Foundation

struct API {
    // Development - https://nw-nimbus-d.nw.r.appspot.com/nimbus/services/v1/
    // Production  - https://mobile-cheque-scan.natwest.com/nimbus/services/v1/
    
    static let ServerURL = "https://api.themoviedb.org/3/movie/popular?api_key=3ccaf9758a0a370710f84fa7a11d3e3d&language=en-US&page=1"
    
    static let upcomingServerURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=3ccaf9758a0a370710f84fa7a11d3e3d&language=en-US&page=1"
}

// MARK: - HTTPHeaderFields
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case xViaDevice = "x-via-device"
    case securityToken = "security_token"
}

enum ContentType: String {
    case json = "application/json"
}

//struct ResultCode {
//    static let OK = "OK"
//    static let KO = "KO"
//}
