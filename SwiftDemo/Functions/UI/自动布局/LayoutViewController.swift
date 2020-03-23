//
//  LayoutViewController.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/11.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit
import SnapKit

enum Animal: Int {
    case cat = 0
    case dog = 1
}

class LayoutViewController: UIViewController {
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var bgView: UIView!
    
    var constract1: Constraint?
    var constract2: Constraint?
    
    var view1: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    var view2: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _: Animal? = .cat
        title = "LayoutViewController"
        
        bgView.addSubview(view1)
        bgView.addSubview(view2)
        
        view1.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.top.equalToSuperview()
            self.constract1 = make.bottom.equalToSuperview().constraint
        }
        
        self.constract1?.deactivate()
        
        view2.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(100)
            make.bottom.equalToSuperview()
            self.constract2 = make.top.equalTo(view1.snp_bottomMargin).offset(20).constraint
        }
        
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if (sender == self.switch1) {
            if (sender.isOn) {
                self.constract1?.deactivate()
                self.constract2?.activate()
            } else {
                self.constract1?.activate()
                self.constract2?.deactivate()
            }
        }
    }
}
