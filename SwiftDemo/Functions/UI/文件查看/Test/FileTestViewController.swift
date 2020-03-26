//
//  FileTestViewController.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/13.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit

enum FileTestItems: CaseIterable {
    case localPdf, network, networkBig, png, localExcel, localSvg, localppt, localDart, localdocx
}

class FileTestViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FileTestVC"
        let barItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(backEvent(_:)))
        navigationItem.leftBarButtonItem = barItem
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FileTestTableViewCell.classForCoder(), forCellReuseIdentifier: "fileCellReuse")
    }

    @objc func backEvent(_ sender: Any) {
        log.info("backEvent")
        dismiss(animated: true, completion: nil)
    }
}

private typealias FileTestViewController_TableView = FileTestViewController
extension FileTestViewController_TableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FileTestItems.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fileCellReuse") as! FileTestTableViewCell
        let item = FileTestItems.allCases[indexPath.row]
        cell.textLabel?.text = "\(item)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log.info("didSelect")
        tableView.deselectRow(at: indexPath, animated: true)
        let item = FileTestItems.allCases[indexPath.row]
        switch item {
        case .localPdf:
            let filePath = Bundle.main.path(forResource: "test", ofType: "pdf")
            let vc = FilePreViewController(fileT: DemoFile(fileType: .pdf, isLocal: true, filePath: filePath))
            let nav = FileNavigationController(rootViewController: vc)
            navigationController?.present(nav, animated: true, completion: nil)
        case .localDart:
            let filePath = Bundle.main.path(forResource: "test", ofType: "dart")
            let vc = FilePreViewController(fileT: DemoFile(fileType: .pdf, isLocal: true, filePath: filePath))
            let nav = FileNavigationController(rootViewController: vc)
            navigationController?.present(nav, animated: true, completion: nil)
        case .localExcel:
            let filePath = Bundle.main.path(forResource: "test", ofType: "xlsx")
            let vc = FilePreViewController(fileT: DemoFile(fileType: .excel, isLocal: true, filePath: filePath))
            let nav = FileNavigationController(rootViewController: vc)
            navigationController?.present(nav, animated: true, completion: nil)
        case .localdocx:
            let filePath = Bundle.main.path(forResource: "test", ofType: "docx")
            let vc = FilePreViewController(fileT: DemoFile(fileType: .excel, isLocal: true, filePath: filePath))
            let nav = FileNavigationController(rootViewController: vc)
            navigationController?.present(nav, animated: true, completion: nil)
        case .network:
            let url = """
            https://wkbjcloudbos.bdimg.com/v1/wenku354//d8767f6deb03a5f14734dc15ddec76c4?responseContentDisposition=attachment%3B%20filename%3D%22%25E5%2584%25BF%25E7%25AB%25A5%25E6%2595%2585%25E4%25BA%258B.pdf.pdf%22%3B%20filename%2A%3Dutf-8%27%27%25E5%2584%25BF%25E7%25AB%25A5%25E6%2595%2585%25E4%25BA%258B.pdf.pdf&responseContentType=application%2Foctet-stream&responseCacheControl=no-cache&authorization=bce-auth-v1%2Ffa1126e91489401fa7cc85045ce7179e%2F2020-03-13T09%3A15%3A51Z%2F3000%2Fhost%2F793924f359185a444da438d126cead2f9a2610bef5a7ef05fdb1fe0046cf0b9a&token=eyJ0eXAiOiJKSVQiLCJ2ZXIiOiIxLjAiLCJhbGciOiJIUzI1NiIsImV4cCI6MTU4NDA5Mzk1MSwidXJpIjp0cnVlLCJwYXJhbXMiOlsicmVzcG9uc2VDb250ZW50RGlzcG9zaXRpb24iLCJyZXNwb25zZUNvbnRlbnRUeXBlIiwicmVzcG9uc2VDYWNoZUNvbnRyb2wiXX0%3D.6lqVJPkt1HMCdgz55EF%2Bk%2B964ySS42SLrYeIVGBPeLY%3D.1584093951
            """

            let vc = FilePreViewController(fileT: DemoFile(fileType: .pdf, isLocal: false, url: url))
            let nav = FileNavigationController(rootViewController: vc)
            navigationController?.present(nav, animated: true, completion: nil)
        case .networkBig:
            let url = "https://s1.q4cdn.com/806093406/files/doc_downloads/test.pdf"
            let vc = FilePreViewController(fileT: DemoFile(fileType: .pdf, isLocal: false, url: url))
            let nav = FileNavigationController(rootViewController: vc)
            navigationController?.present(nav, animated: true, completion: nil)
        default:
            log.info("default")
        }
    }
}
