//
//  MarvelAPI.swift
//  MarvelApp
//
//  Created by Marcelo on 02/06/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift
import SwiftyJSON

struct MarvelAPIKeys {
    static let baseURL = "https://gateway.marvel.com/"
    static let privatekey = ""
    static let apikey = ""
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(privatekey)\(apikey)".md5()
    static let parametersAuth = ["apikey": apikey, "ts":ts, "hash":hash]

    static func charactersURL(_ name:String? = nil) -> String{
        if let name = name, let nameEncoded = name.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            return baseURL + "v1/public/characters?name=\(nameEncoded)"
        } else {
            return baseURL + "v1/public/characters"
        }
    }
}

class MarvelAPI : NSObject {
 
    func characters(name:String? = nil, success:@escaping ((_ characters:[Character]) -> Void), fail:@escaping ((_ error:Error?) -> Void)) {
    
        Alamofire.request(MarvelAPIKeys.charactersURL(name), parameters:MarvelAPIKeys.parametersAuth).validate().responseJSON { response in
            switch response.result {
            case .success:
                var characters = [Character]()
                if let result = response.result.value {
                    let json = JSON(result)
                    characters = json["data"]["results"].arrayValue.map({Character(json: $0)})
                }
                success(characters)
            case .failure(let error):
                print(error)
                fail(error)
            }
        }
    }

    
    
}

