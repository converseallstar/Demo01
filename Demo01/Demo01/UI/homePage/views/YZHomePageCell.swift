//
//  YZHomePageCell.swift
//  Demo01
//
//  Created by 胡一钟 on 2018/6/13.
//  Copyright © 2018年 hyz. All rights reserved.
//

import UIKit
import Kingfisher

let YZHomePageCellIdentifier = "YZHomePageCellIdentifier"

class YZHomePageCell: UITableViewCell {
    
    @IBOutlet weak var dispalyImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    func configCell(text: String?, imageUrl: String?) {
        
        if let iu = imageUrl
        {
            let url = URL(string: iu)
            dispalyImageView.kf.setImage(with: url)
        }
        
        descLabel.text = text
    }

}

