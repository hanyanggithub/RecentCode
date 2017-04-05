//
//  PageViewController.swift
//  QuizText
//
//  Created by mac on 17/4/5.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    var channelTab: ChannelView?
    var models:Array<ChannelModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        self.channelTab = ChannelView.init(frame: CGRect.init(x: 0, y: 64, width: self.view.frame.width, height: 44.0))
        self.view.addSubview(self.channelTab!)
        
        models = Array.init()
        for i in 0...9 {
           let model = ChannelModel.init(dic: ["name":"频道\(i)"])
            models?.append(model!)
        }
        self.channelTab?.setTabClickedWithIndexBlock({ (Int) in
            print("点击tab位置\(Int)")
        })
        self.channelTab?.update(withChannelModels: self.models)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
