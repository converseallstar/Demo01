//
//  YZHomePageRequest.swift
//  Demo01
//
//  Created by 胡一钟 on 2018/6/13.
//  Copyright © 2018年 hyz. All rights reserved.
//

import UIKit
import SwiftyJSON

class YZHomePageRequest<T>: BaseRequest<T> {
    
    override func getHttpResource() -> String
    {
        return "mockapi/data"
    }
    
    override func willStart() -> Bool
    {
        return true
    }
    
    override func onReceieveJson(_ data: JSON) -> T?
    {
        var array: [YZHomePageModel] = [YZHomePageModel]()
        
        for (_, value) in data {
            let model = YZHomePageModel(jsonData: value)
            array.append(model)
        }
        if let a = array as? T {
            return a
        }
        return nil
    }
    
    deinit {
        print("1 释放")
    }
}
