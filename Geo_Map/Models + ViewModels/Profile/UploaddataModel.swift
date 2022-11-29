//
//  UploaddataModel.swift
//  Geo_Map
//
//  Created by Mac Mini on 11/05/22.
//

import Foundation
import EVReflection

// MARK: - Upload Data Model
class UploadDataModel : EVObject {
    var name = ""
    var key = ""
    var data : Data?
    var extention = ""
    var mimeType = ""
//    var imageContent : UIImage?
    
    init(name:String, key:String, data:Data?, extention:String, mimeType:String) {
        self.name = name
        self.key = key
        self.data = data
        self.extention = extention
        self.mimeType = mimeType
//        self.imageContent = imageContent
    }
    
    required init() {
        super.init()
    }
    
}
