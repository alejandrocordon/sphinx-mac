//
//  API+AuthenticationExtension.swift
//  Sphinx
//
//  Created by Tomas Timinskas on 27/03/2022.
//  Copyright © 2022 Tomas Timinskas. All rights reserved.
//

import Foundation

extension API {
    
    public func generateToken(
        pubkey: String,
        password: String? = nil,
        additionalHeaders: [String: String] = [:],
        callback: @escaping SuccessCallback,
        errorCallback: @escaping EmptyCallback
    ) {
        var route = "/contacts/tokens"
        if let password = password {
            route = "\(route)?pwd=\(password)"
        }
        
        let parameters: [String : AnyObject] = ["pubkey": pubkey as AnyObject]
        
        guard let request = getURLRequest(
                route: route,
                params: parameters as NSDictionary?,
                method: "POST",
                additionalHeaders: additionalHeaders
        ) else {
            errorCallback()
            return
        }
        
        sphinxRequest(request) { response in
            switch response.result {
            case .success(let data):
                if let json = data as? NSDictionary {
                    if let success = json["success"] as? Bool, success {
                        callback(success)
                    } else {
                        errorCallback()
                    }
                }
            case .failure(_):
                errorCallback()
            }
        }
    }
    
    public func getTransportKey(
        callback: @escaping TransportKeyCallback,
        errorCallback: @escaping EmptyCallback
    ) {
        guard let request = getUnauthenticatedURLRequest(
                route: "/request_transport_key",
                params: nil,
                method: "GET"
        ) else {
            errorCallback()
            return
        }
        
        sphinxRequest(request) { response in
            switch response.result {
            case .success(let data):
                if let json = data as? NSDictionary {
                    if let success = json["success"] as? Bool,
                       let response = json["response"] as? NSDictionary, success {
                        if let transportKey = response["transport_key"] as? String {
                            callback(transportKey)
                            return
                        }
                    }
                    errorCallback()
                }
            case .failure(_):
                errorCallback()
            }
        }
    }
}
