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
        
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
}
