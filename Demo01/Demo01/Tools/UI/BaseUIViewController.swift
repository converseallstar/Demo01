//
//  BaseUIViewController.swift
//  KKMJ
//
//  Created by jimmy on 2018/6/5.
//  Copyright © 2018年 VCredit. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .init(rawValue: 0)
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
}
