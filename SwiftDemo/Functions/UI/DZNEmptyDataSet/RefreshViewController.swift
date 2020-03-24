//
//  RefreshViewController.swift
//  SwiftDemo
//
//  Created by 赵千千 on 2020/3/24.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit

class RefreshViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var items: [String] = ["1", "2"]

    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuse")
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
                        self?.tableView.mj_footer?.endRefreshingWithNoMoreData()
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

extension RefreshViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse")
        cell?.textLabel?.text = "index = \(indexPath.row)"
        return cell ?? UITableViewCell()
    }
}
