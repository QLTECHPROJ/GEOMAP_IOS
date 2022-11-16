//
//  LogoutViewModel.swift
//  NSC_iOS
//
//  Created by Mac Mini on 09/05/22.
//

import Foundation

class LogoutViewModel {
    
     func callLogoutAPI(completion: @escaping (Bool) -> Void) {
     
         let parameters = APIParametersModel()
         parameters.userId = JSON(UserModelClass.current.userId as Any).stringValue
         parameters.deviceType = DeviceDetail.shared.deviceType
         parameters.deviceToken = GFunctions.shared.getDeviceToken()
         parameters.deviceId = DeviceDetail.shared.uuid
        
         APIManager.shared.callAPIWithJSON(router: APIRouter.logout(parameters.toDictionary())) { responseJSON, data, statusCode, message, completion in
             
             if completion{
                 
                 GFunctions.shared.showSnackBar(message: message)
                 
                 DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                   
                     AppDelegate.shared.updateWindow()
                 }
             }
         }
    }
}

