//
//  Item.swift
//  MarvelApp
//
//  Created by Marcelo on 03/06/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Item : NSObject{
    
    var name: String = ""
    
    init(json : JSON) {
        super.init()
        name = json["name"].string ?? name
    }
}
