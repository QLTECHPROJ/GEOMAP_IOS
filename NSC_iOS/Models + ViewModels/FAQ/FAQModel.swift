//
//  FAQModel.swift
//  NSC_iOS
//
//  Created by Mac Mini on 20/08/22.
//

import Foundation
import EVReflection

class FAQModel : EVObject {
    var ResponseCode = ""
    var ResponseMessage = ""
    var ResponseStatus = ""
    var ResponseData = [FAQDataModel]()
}

class FAQDataModel : EVObject {
    var ID = ""
    var Title = ""
    var Desc = ""
    var VideoURL = ""
    var Category = ""
    var isSelected = false
}
