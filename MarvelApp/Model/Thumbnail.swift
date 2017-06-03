//
//  Thumbnail.swift
//  MarvelApp
//
//  Created by Marcelo on 02/06/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Thumbnail : NSObject {
    var path: String = ""
    var imageExtension: String = ""
    
    func fullPath() -> String {
        return "\(path).\(imageExtension)"
    }
    
    init(json:JSON) {
        super.init()
        path = json["path"].string ?? path
        imageExtension = json["extension"].string ?? imageExtension
    }
}
