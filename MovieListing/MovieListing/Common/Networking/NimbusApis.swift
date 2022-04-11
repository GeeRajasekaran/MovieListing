//
//  NimbusApis.swift
//  Nimbus
//
//  Created by CVN on 16/05/20.
//  Copyright © 2020 Raj. All rights reserved.
//

import Foundation
import Alamofire

enum NimbusAPI {
    case checkUserIsValid(body: Parameters)
    case getOTPForUser(body: Parameters)
    case verifyOTPForUser(body: Parameters)
    case setPassword(body: Parameters)
    case login(body: Parameters)
    case recentHistory(body: Parameters)
    case dailyLimit(body: Parameters)
    case startTransaction(body: Parameters)
    case addItem(body: Parameters)
    case commitTransaction(body: Parameters)
    case cancelTransaction(body: Parameters)
    case removeItem(body: Parameters)
    case completeTransactionHistory(body: Parameters)
    case chequeDetails(body: Parameters)
    case logOut(body: Parameters)
    case keepAlive(body: Parameters)
    case updatePassword(body: Parameters)
    case feedBack(body: Parameters)
    case settings(body: Parameters)
}

extension NimbusAPI: URLRequestConvertible {
    
    var serverURL: URL {
        return URL(string: API.ServerURL)!
    }
    var path: String {
        switch self {
        case .setPassword:
            return "users/setPassword"
        case .checkUserIsValid:
            return "users/isRegistered"
        case .getOTPForUser :
            return "otp/send"
        case .verifyOTPForUser :
            return "otp/verify"
        case .login :
            return "users/login"
        case .recentHistory :
            return "transactions/recentHistory"
        case .dailyLimit :
            return "transactions/dailyLimit"
        case .startTransaction :
            return "transactions/start"
        case .addItem :
            return "transactions/addItem"
        case .commitTransaction :
           // return "transactions/commit"
            return "transactions/commitWithFeedback"
        case .cancelTransaction :
            return "transactions/cancel"
        case .removeItem :
            return "transactions/removeItem"
        case .completeTransactionHistory :
            return "transactions/completeHistory"
        case .chequeDetails :
            return "transactions/chequeDetails"
        case .logOut :
            return "users/logout"
        case .keepAlive :
            return "users/keepalive"
        case .updatePassword :
            return "users/updatePassword"
        case .feedBack :
            return "users/feedback"
        case .settings :
            return "users/settings"
        }

    }
    private var method: HTTPMethod {
        switch self {
        case  .checkUserIsValid, .getOTPForUser, .verifyOTPForUser , .login , .recentHistory, .dailyLimit, .startTransaction, .addItem, .commitTransaction, .cancelTransaction, .removeItem, .completeTransactionHistory, .chequeDetails, .logOut, .keepAlive, .feedBack, .settings :
            return .post
        case .setPassword, .updatePassword :
            return .put
        }
    }
    private var parameters: Parameters? {
        
        switch self {
        case .setPassword(body: let body):
            return body
        case .checkUserIsValid(body: let body):
            return body
        case .getOTPForUser(body: let body) :
            return body
        case .verifyOTPForUser(body: let body) :
            return body
        case .login(body: let body) :
            return body
        case .dailyLimit(body: let body) :
            return body
        case .startTransaction(body: let body) :
            return body
        case .addItem(body: let body) :
            return body
        case .commitTransaction(body: let body) :
            return body
        case .cancelTransaction(body: let body) :
            return body
        case .removeItem(body: let body) :
            return body
        case .completeTransactionHistory(body: let body) :
            return body
        case .chequeDetails(body: let body) :
            return body
        case .recentHistory(body: let body) :
            return body
        case .logOut(body: let body) :
            return body
        case .keepAlive(body: let body) :
            return body
        case .updatePassword(body: let body) :
            return body
        case .feedBack(body: let body) :
            return body
        case .settings(body: let body) :
            return body
        }
    }
    
    var baseURL: String {
        
        return serverURL.absoluteString
    }
    var queryItems: [URLQueryItem] {
        let path = self.path
        var queryItems: [URLQueryItem] = []
        if let url = URLComponents(string: path) {
            queryItems += url.queryItems ?? []
        }
        switch self {
            
        default :
            return []
        }
    }
    
    // MARK: - URLRequest for Alamofire
    /**
     Any changes to the request like headers and parameters to be done here as after this the request cannot be modified.
     */
    
    func asURLRequest() throws -> URLRequest {
        
        let urlString = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        var urlComponents = URLComponents(string: (baseURL + urlString))!
        if queryItems.isEmpty {
            
        } else {
            urlComponents.queryItems = queryItems
        }
        let url = urlComponents.url!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 30.0
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        switch self {
            
            // todo: settoken
            
        default:
            urlRequest.setValue("", forHTTPHeaderField: HTTPHeaderField.securityToken.rawValue)
        }
        
        switch self {
            
        default:
            if let parameters = parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
            
            print("request: \(urlRequest.url?.absoluteString ?? "")")
            print("request: \(String(describing: urlRequest.allHTTPHeaderFields))")
            print("request: \(String(describing: String(data: urlRequest.httpBody ?? Data(), encoding: .utf8)))")
            return urlRequest
        }
    }
    
}
