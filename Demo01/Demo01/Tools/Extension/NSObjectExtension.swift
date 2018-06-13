//
//  NSObjectExtension.swift
//  KKMJ
//
//  Created by jimmy on 2018/6/7.
//  Copyright © 2018年 VCredit. All rights reserved.
//

import UIKit

extension NSObject
{
    func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
    {
        if let nav = base as? UINavigationController
        {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController
        {
            return currentViewController(base: tab.selectedViewController)
        }
        
        if let presented = base?.presentedViewController
        {
            return currentViewController(base: presented)
        }
        
        return base
    }
}
