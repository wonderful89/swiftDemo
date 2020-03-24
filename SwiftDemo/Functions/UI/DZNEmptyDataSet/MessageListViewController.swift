//
//  MessageListViewController.swift
//  TencentClassrooom
//
//  Created by j0 on 2018/12/6.
//  Copyright © 2018 Chen. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController {
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    
    //老师应用
    var items: [String] = ["1", "2"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let time = DispatchTime.now() + 3.0
        DispatchQueue.main.asyncAfter(deadline: time) { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.reloadEmptyDataSet(); // 强制刷新
        }
        initUI()
    }

    @IBAction func swicthChanged(_ sender: Any) {
        tableView.reloadData()
    }
    
    func initUI(){
        if #available(iOS 11.0, *) {
            self.edgesForExtendedLayout = UIRectEdge.all
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.edgesForExtendedLayout = UIRectEdge()
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.title = "消息"
        self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)

        tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        tableView.mj_header = {
            let stateHeader = MJRefreshStateHeader { [weak self] in
                let time = DispatchTime.now() + 1.0
                DispatchQueue.main.asyncAfter(deadline: time) {
                    let items = Array(repeating: "1", count: 20)
                    self?.items = items
                    self?.tableView.reloadData()
                    self?.tableView.mj_header?.endRefreshing()
                    self?.tableView.mj_footer?.endRefreshing()
                }
            }
            stateHeader.stateLabel?.textColor = UIColor.lightGray
            stateHeader.lastUpdatedTimeLabel?.textColor = UIColor.lightGray
            return stateHeader
        }()
        
        tableView.mj_footer = {
            let footer = MJRefreshAutoNormalFooter { [weak self] in
                let time = DispatchTime.now() + 1.0
                DispatchQueue.main.asyncAfter(deadline: time) {
                    if (self!.items.count <= 30) {
                        let items = Array(repeating: "1", count: 10)
                        self?.items.append(contentsOf: items)
                        self?.tableView.reloadData()
                        self?.tableView.mj_footer?.endRefreshing()
                    } else {
                        self?.items = []
                        self?.tableView.reloadData()
                        self?.tableView.mj_footer?.endRefreshing()
                    }
                }
                
            }
            footer.setTitle("没有数据", for: .noMoreData)
            footer.setTitle("下拉刷新", for: .pulling)
            footer.setTitle("刷新中", for: .refreshing)
            footer.setTitle("即将刷新..", for: .willRefresh)
            return footer
        }()

        // 马上进入刷新状态
        tableView.mj_header?.beginRefreshing()
        let time = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: time) { [weak self] in
            self?.tableView.mj_header?.endRefreshing()
        }
    }

}
extension MessageListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "index = \(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.switch.isOn ? items.count : 0
    }
}
extension MessageListViewController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    internal func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "empty_content")
    }
    
    internal func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: "您还没有收到消息~", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor: UIColor.blue])
    }
    internal func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let text = "点击刷新"
        
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(14.0)),NSAttributedString.Key.foregroundColor : UIColor.red]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    
    internal func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .lightGray
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
