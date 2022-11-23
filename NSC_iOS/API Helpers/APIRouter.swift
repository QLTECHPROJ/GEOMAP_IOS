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
    
    case countrylist
    case statelist([String:String])
    case citylist([String:String])
    case coachrole
    case categorylist
    case logincheck([String:String])
    
    case login([String:Any])
    case coachregister([String:String])
    case coachdetails([String:String])
    case coachstatus([String:String])
    case referdata([String:String])
    
    case delete_user([String:Any])
    case logout([String:Any])
    
    case camplisting([String:String])
    case campdetails([String:String])
    case daylisting([String:String])
    
    case notification_listing([String:String])
    
    case coachupdatepersonaldetails([String:String])
    case coachupdatebankdetails([String:String])
    case profile_update([String:Any])
    case verify_refercode([String:String])
    case myearning([String:String])
    case inviteuser([String:String])
    
    case applyForACampListing([String:String])
    case applycampdatasave([String:String])
    
    case kidsattendanceshow([String:String])
    
    case kidsattendancesave([String:Any])
    
    case ur_or_listing([String:Any])
    
    case ur_listing_view_all([String:Any])
    
    case or_listing_view_all([String:Any])
    
    case user_details([String:Any])
    
    case attribute_data_number
    case sample_collecteds
    case weathering_data
    case rock_strength_data
    case water_condition_data
    case type_of_geological_structures
    case types_of_fault
    
    case ur_detail([String:Any])
    case or_detail([String:Any])
    case contact_insert([String:Any])
    
    case app_version([String:Any])
    
    case faq_data
    
    case forgot_password([String:Any])
    
    case sync_data([String:Any])
    
    case underground_insert([String:Any])
    
    case open_cast_insert([String:Any])
    
    var route: APIRoute {
        
        switch self {
            
            
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
            
        case .delete_user(let data):
            return APIRoute(path: "delete_user", method: .post, data: data)
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
        case .profile_update(let data):
            return APIRoute(path: "profile_update", method: .post, data: data)
            
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
            
        case .attribute_data_number:
            return APIRoute(path: "attribute_data_number", method: .get)
            
        case .ur_or_listing(let data):
            return APIRoute(path: "ur_or_listing", method: .post, data: data)
            
        case .ur_listing_view_all(let data):
            return APIRoute(path: "ur_listing_view_all", method: .post, data: data)
            
        case .or_listing_view_all(let data):
            return APIRoute(path: "or_listing_view_all", method: .post, data: data)
            
        case .user_details(let data):
            return APIRoute(path: "user_details", method: .post, data: data)
            
        case .sample_collecteds:
            return APIRoute(path: "sample_collecteds", method: .get)
            
        case .weathering_data:
            return APIRoute(path: "weathering_data", method: .get)
            
        case .rock_strength_data:
            return APIRoute(path: "rock_strength_data", method: .get)
            
        case .water_condition_data:
            return APIRoute(path: "water_condition_data", method: .get)
            
        case .type_of_geological_structures:
            return APIRoute(path: "type_of_geological_structures", method: .get)
            
        case .types_of_fault:
            return APIRoute(path: "types_of_fault", method: .get)
            
        case .ur_detail(let data):
            
            return APIRoute(path: "ur_detail", method: .post, data: data)
            
        case .or_detail(let data):
            
            return APIRoute(path: "or_detail", method: .post, data: data)
            
        case .contact_insert(let data):
            
            return APIRoute(path: "contact_insert", method: .post, data: data)
            
        case .app_version(let data):
            
            return APIRoute(path: "app_version", method: .post, data: data)
        case .faq_data :
            
            return APIRoute(path: "faq_data", method: .get)
            
        case .forgot_password(let data) :
            
            return APIRoute(path: "forgot_password", method: .post, data: data)
            
        case .sync_data(let data) :
            
            return APIRoute(path: "sync_data", method: .post, data: data)
            
            
        case .underground_insert(let data) :
            
            return APIRoute(path: "underground_insert", method: .post, data: data)
            
        case .open_cast_insert(let data) :
            
            return APIRoute(path: "open_cast_insert", method: .post, data: data)
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
