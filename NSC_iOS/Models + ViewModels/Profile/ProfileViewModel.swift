//
//  ProfileViewModel.swift
//  NSC_iOS
//
//  Created by Mac Mini on 11/05/22.
//

import Foundation

class ProfileViewModel {
    
    var profileData: LoginDataModel?
    
    func callProfileUpdateAPI(parameters : [String:String], uploadParameters : [UploadDataModel], completion: @escaping (Bool) -> Void) {
        APIManager.shared.callUploadWebService(apiUrl: APIRouter.profileUpdate(parameters).urlRequest!.url!.absoluteString, includeHeader: true, parameters: parameters, uploadParameters: uploadParameters, httpMethod: .post) { [weak self] (response : LoginModel?) in
            if response?.ResponseCode == "200", let responseData = response?.ResponseData {
                self?.profileData = responseData
                
                showAlertToast(message: response?.ResponseMessage ?? "")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}

