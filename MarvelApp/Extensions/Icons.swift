//
//  Icons.swift
//  MarvelApp
//
//  Created by Marcelo on 02/06/17.
//  Copyright © 2017 Marcelo. All rights reserved.
//

import UIKit

extension UIImage {
    class func list() -> UIImage? {
        return UIImage(named: "iconList")
    }
    
    class func grid() -> UIImage? {
        return UIImage(named: "iconGrid")
    }
    
    class func filterFilled() -> UIImage? {
        return UIImage(named: "iconFilterFilled")
    }
    
    class func filterEmpty() -> UIImage? {
        return UIImage(named: "iconFilterHollow")
    }
}
