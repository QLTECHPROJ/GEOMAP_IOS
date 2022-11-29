//
//  ListDataModel.swift
//  Geo_Map
//
//  Created by Dhruvit on 28/04/22.
//

import Foundation
import EVReflection

class ListDataModel : EVObject {
    var ResponseData: [ListItem]?
    var ResponseCode: String?
    var ResponseMessage: String?
    var ResponseStatus: String?
}

class ListItem: EVObject {
    var ID = ""
    var Name = ""
    var ShortName = ""
    var Code = ""
    
    // For State Listing
    var CountryId = ""
    
    // For City Listing
    var StateId = ""
    
    var Selected = ""
    
    init(id : String, name : String) {
        self.ID = id
        self.Name = name
    }
    
    required init() {
        
    }
    
}
