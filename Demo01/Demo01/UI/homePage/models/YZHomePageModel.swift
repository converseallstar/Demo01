//
//  YZHomePageModel.swift
//  Demo01
//
//  Created by 胡一钟 on 2018/6/13.
//  Copyright © 2018年 hyz. All rights reserved.
//

import UIKit
import SwiftyJSON

class YZHomePageModel: NSObject {

    var image: String?
    var text: String?
    
    init(jsonData: JSON) {
        image = jsonData["image"].stringValue
        text = jsonData["text"].stringValue
    }
    
    override var description: String {
        let desc = "image == " + (image ?? "") + "text == " + (text ?? "")
        return desc
    }
}
