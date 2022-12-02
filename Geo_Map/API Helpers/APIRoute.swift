//
//  APIRoute.swift
//  NSC_iOS
//
//  Created by Dhruvit on 28/04/22.
//

import Foundation
import Alamofire


class APIRoute {
    let path: String
    let method: Alamofire.HTTPMethod
    let data: [String: Any]?
    
    init(path: String, method: Alamofire.HTTPMethod, data: [String: Any]) {
        self.path = path
        self.method = method
        self.data = data
    }
    
    init(path: String, method: Alamofire.HTTPMethod) {
        self.path = path
        self.method = method
        self.data = nil
    }
    
    var encoding: Alamofire.ParameterEncoding {
        switch method {
        case .post, .put, .patch, .delete:
            return JSONEncoding()
        default:
            return URLEncoding()
        }
    }
}
