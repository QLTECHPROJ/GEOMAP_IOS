//
//  APIRouter.swift
//  NSC_iOS
//
//  Created by Dhruvit on 28/04/22.
//

import Foundation
import CryptoKit
import Alamofire


enum APIRouter : URLRequestConvertible {
    
    case appversion([String:String])
    case countrylist
    case statelist([String:String])
    case citylist([String:String])
    case coachrole
    case categorylist
    case logincheck([String:String])
    
    case login([String:String])
    case coachregister([String:String])
    case coachdetails([String:String])
    case coachstatus([String:String])
    case referdata([String:String])
    
    case deletecoach([String:String])
    case logout([String:String])
    
    case camplisting([String:String])
    case campdetails([String:String])
    case daylisting([String:String])
    
    case notification_listing([String:String])
    
    case coachupdatepersonaldetails([String:String])
    case coachupdatebankdetails([String:String])
    case profileUpdate([String:String])
    case verify_refercode([String:String])
    case myearning([String:String])
    case inviteuser([String:String])
    
    case applyForACampListing([String:String])
    case applycampdatasave([String:String])
    
    case kidsattendanceshow([String:String])
    case kidsattendancesave([String:Any])
    
    var route: APIRoute {
        switch self {
        case .appversion(let data):
            return APIRoute(path: "App Version", method: .post, data: data)
        case .countrylist:
            return APIRoute(path: "country-listing", method: .get)
        case .statelist(let data):
            return APIRoute(path: "state-listing", method: .post, data: data)
        case .citylist(let data):
            return APIRoute(path: "city-listing", method: .post, data: data)
        case .coachrole:
            return APIRoute(path: "coachrole", method: .get)
        case .categorylist:
            return APIRoute(path: "category-listing", method: .get)
        case .logincheck(let data):
            return APIRoute(path: "logincheck", method: .post, data: data)
        
        case .login(let data):
            return APIRoute(path: "login", method: .post, data: data)
        case .coachregister(let data):
            return APIRoute(path: "coachregister", method: .post, data: data)
        case .coachdetails(let data):
            return APIRoute(path: "coachdetails", method: .post, data: data)
        case .coachstatus(let data):
            return APIRoute(path: "coachstatus", method: .post, data: data)
        case .referdata(let data):
            return APIRoute(path: "referdata", method: .post, data: data)
            
        case .deletecoach(let data):
            return APIRoute(path: "deletecoach", method: .post, data: data)
        case .logout(let data):
            return APIRoute(path: "logout", method: .post, data: data)
        
        case .camplisting(let data):
            return APIRoute(path: "camplisting", method: .post, data: data)
        case .campdetails(let data):
            return APIRoute(path: "campdetails", method: .post, data: data)
        case .daylisting(let data):
            return APIRoute(path: "day-listing", method: .post, data: data)
            
        case .notification_listing(let data):
            return APIRoute(path: "notification-listing", method: .post, data: data)
            
        case .coachupdatepersonaldetails(let data):
            return APIRoute(path: "coachupdatepersonaldetails", method: .post, data: data)
        case .coachupdatebankdetails(let data):
            return APIRoute(path: "coachupdatebankdetails", method: .post, data: data)
        case .profileUpdate(let data):
            return APIRoute(path: "profileUpdate", method: .post, data: data)
        case .verify_refercode(let data):
            return APIRoute(path: "verify-refercode", method: .post, data: data)
        case .myearning(let data):
            return APIRoute(path: "myearning", method: .post, data: data)
        case .inviteuser(let data):
            return APIRoute(path: "invite-user", method: .post, data: data)
            
        case .applyForACampListing(let data):
            return APIRoute(path: "applyfor-a-camplisting", method: .post, data: data)
        case .applycampdatasave(let data):
            return APIRoute(path: "applycampdatasave", method: .post, data: data)
            
        case .kidsattendanceshow(let data):
            return APIRoute(path: "kids-attendance-show", method: .post, data: data)
        case .kidsattendancesave(let data):
            return APIRoute(path: "kids-attendance-save", method: .post, data: data)
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let route = self.route
        let url = URL(string: API_BASE_URL)!
        var mutableURLRequest = URLRequest(url: url.appendingPathComponent(route.path))
        mutableURLRequest.httpMethod = route.method.rawValue
        
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        // mutableURLRequest.setValue("1", forHTTPHeaderField: "Test")
        mutableURLRequest.setValue(APIManager.shared.generateToken(), forHTTPHeaderField: "Oauth")
        mutableURLRequest.setValue(DEVICE_UUID, forHTTPHeaderField: "Yaccess")
        
        print("API Parameters :- ", route.data ?? "")
        print("API Path :- ", API_BASE_URL + route.path)
        
        if let data = route.data {
            if route.method == .get {
                return try Alamofire.URLEncoding.default.encode(mutableURLRequest, with: data)
            }
            return try Alamofire.JSONEncoding.default.encode(mutableURLRequest, with: data)
        }
        return mutableURLRequest
    }
    
}


extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}
