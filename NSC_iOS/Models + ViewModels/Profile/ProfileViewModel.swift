//
//  ProfileViewModel.swift

import Foundation

class ProfileViewModel {
    
    func callProfileUpdateAPI(parameters : [String:Any], uploadParameters : [UploadDataModel], completion: @escaping (Bool) -> Void) {
       
        debugPrint(parameters)
        
        APIManager.shared.callUploadWebService(apiUrl: APIRouter.profile_update(parameters).urlRequest!.url!.absoluteString, includeHeader: true, parameters: parameters, uploadParameters: uploadParameters, httpMethod: .post) { [weak self] (response : LoginModel?) in
            if response?.ResponseCode == "200", let responseData = response?.ResponseData {
               
                GFunctions.shared.showSnackBar(message: response?.ResponseMessage ?? "Error")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func callAPIGetUserProfile(isLoader : Bool = false, completionBlock: @escaping (JSON?,String?,String?,Bool) -> Void) {
        
        let parameters = APIParametersModel()
        parameters.userId = JSON(UserModelClass.current.userId as Any).stringValue
        debugPrint(parameters)
        
        APIManager.shared.callAPIWithJSON(router: APIRouter.user_details((parameters.toDictionary())),isLoader : isLoader,showToast : false) { responseData, data, statusCode, message, completion in
            if completion, statusCode == ApiKeys.ApiStatusCode.success.rawValue, let receivdeData = data {
                
                debugPrint(receivdeData)
                let userModel = UserModelClass(fromJson: receivdeData["ResponseData"])
                userModel.saveUserSessionInToDefaults()
                userModel.saveUserDetailInDefaults()
                CoreDataManager.shared.insertAllTableData(receivdeData["ResponseData"])
                completionBlock(receivdeData,statusCode,message,true)
            }
            else{
                completionBlock(nil,statusCode,message,false)
            }
        }
    }
    
}

