//
//  Character.swift
//  MarvelApp
//
//  Created by Marcelo on 02/06/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Character : NSObject {
    
    var id: Int = 0
    var name: String = ""
    var descriptionBio: String = ""
    var thumbnail: Thumbnail?
    var comics: [Item]?
    var series: [Item]?
    var stories: [Item]?
    var events: [Item]?
    var linkDetails:URL?
    
    init(json : JSON) {
        super.init()
        
        id = json["id"].int ?? id
        name = json["name"].string ?? name
        descriptionBio = json["description"].string ?? descriptionBio
        thumbnail = Thumbnail(json:json["thumbnail"])
        comics = json["comics"]["items"].arrayValue.map({Item(json:$0)})
        series = json["series"]["items"].arrayValue.map({Item(json:$0)})
        stories = json["stories"]["items"].arrayValue.map({Item(json:$0)})
        events = json["events"]["items"].arrayValue.map({Item(json:$0)})
        if let url = json["urls"][0]["url"].string {
            linkDetails = URL(string: url)
        }
    }
}
