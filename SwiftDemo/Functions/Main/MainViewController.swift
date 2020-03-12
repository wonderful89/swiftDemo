//
//  MainViewController.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/6.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SwiftDemo"

        initTableView()
    }
}

private typealias MainViewControllerTableView = MainViewController
extension MainViewControllerTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TestConfig.getGroupLength(test: TestConfig.allCases[section])
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 61
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return TestConfig.allCases.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let value = TestConfig.allCases[section]
        return value.rawValue
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseID")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reuseID")
        }
        let row = indexPath.row
        let configEnum = TestConfig.allCases[indexPath.section]
        let indexStr = TestConfig.getGroupItem(test: configEnum, index: row)
        cell!.textLabel?.text = "\(row + 1). \(indexStr)"

        return cell!
    }

    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let configEnum = TestConfig.allCases[indexPath.section]
        let indexStr = TestConfig.getGroupItem(test: configEnum, index: indexPath.row)
        log.info("处理: \(indexStr)")

        let value = TestConfig.allCases[indexPath.section]
        switch value {
        case .UIGroup:
            handleUI(type: indexStr)
        case .logicGroup:
            handleLogic(type: indexStr)

        default:
            log.warning("没有得到处理")
        }
    }
}
