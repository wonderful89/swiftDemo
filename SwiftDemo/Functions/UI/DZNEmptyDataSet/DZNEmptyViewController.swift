//
//  DZNEmptyViewController.swift
//  SwiftDemo
//
//  Created by 赵千千 on 2020/3/24.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit

class DZNEmptyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DZNTempTest"
        view.backgroundColor = .white
        
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if (sender.isOn) {
            dataArr = []
        } else {
            dataArr = ["11", "22", "33"]
        }
        
        tableView.reloadData()
    }
}

extension DZNEmptyViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataArr[indexPath.row]
        return cell
    }
}

extension DZNEmptyViewController:DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    internal func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "empty_content")
    }

//    internal func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//        return NSAttributedString(string: "空内容~", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.red])
//    }
//
//    internal func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
//        let text = "点击刷新"
//
//        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(14.0)), NSAttributedString.Key.foregroundColor: UIColor.blue]
//        return NSAttributedString(string: text, attributes: attributes)
//    }
//
//    internal func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
//        return UIColor.lightGray
//    }
//
//    internal func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
//        log.info("emptyDataSetShouldDisplay")
//        return true
//    }
//
//    internal func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
//        return true
//    }
//
//    internal func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
//        return false
//    }
//
//    internal func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
//        log.info("emptyDataSetShouldAnimateImageView")
//        return false
//    }
//
//    internal func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
//        log.info("emptyDataSet didTap")
//    }
    internal func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: "您还没有收到消息~", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor:UIColor.red])
    }
    internal func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let text = "点击刷新"
        
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(14.0)),NSAttributedString.Key.foregroundColor : UIColor.blue]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    
    internal func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.lightGray
    }
    
    internal func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    internal func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    internal func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    
    internal func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    
    internal func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        
    }
}

