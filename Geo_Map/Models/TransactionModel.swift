//
//  EarningModel.swift


import Foundation
import EVReflection

class EarningModel: EVObject {
    var ResponseData: EarningDataModel?
    var ResponseCode: String?
    var ResponseMessage: String?
    var ResponseStatus: String?
}

class EarningDataModel: EVObject {
    var TotalBalance = ""
    var transactions = [TransactionModel]()
}

class TransactionModel: EVObject {
    var ID = ""
    var Name = ""
    var Profile_Image = ""
    var Coach_ID = ""
    var Amount = ""
    var Txn_ID = ""
    var Date = ""
}
