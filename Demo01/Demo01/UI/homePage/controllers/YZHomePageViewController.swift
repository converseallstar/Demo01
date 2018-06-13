//
//  YZHomePageViewController.swift
//  Demo01
//
//  Created by 胡一钟 on 2018/6/13.
//  Copyright © 2018年 hyz. All rights reserved.
//

import UIKit
import MBProgressHUD

class YZHomePageViewController: BaseUIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var dataArray: [YZHomePageModel] = [YZHomePageModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        prepareData()
    }
    
    private func prepareData()
    {
        let request = YZHomePageRequest<[YZHomePageModel]>()
        MBProgressHUD.showAdded(to: view, animated: true)
        request.execute().onSuccess { [weak self](models) in
            self?.dataArray = models
            self?.myTableView.isHidden = false
            self?.myTableView.reloadData()
            }.onFailed { [weak self](error) in
                self?.myTableView.isHidden = true
            }.onComplete { [weak self] in
                if let v = self?.view
                {
                    MBProgressHUD.hide(for: v, animated: true)
                }
        }
    }

    private func setupUI()
    {
        myTableView.estimatedRowHeight = 265
    }

}

extension YZHomePageViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: YZHomePageCellIdentifier, for: indexPath) as? YZHomePageCell
        {
            let model = dataArray[indexPath.row]
            
            cell.configCell(text: model.text, imageUrl: model.image)
            
            return cell
        }
        return UITableViewCell()
    }
}






