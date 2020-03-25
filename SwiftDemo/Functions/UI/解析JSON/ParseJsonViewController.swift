//
//  ParseJsonViewController.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/23.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import HandyJSON
import UIKit

// from: https://www.jianshu.com/p/8d8b559346ec

let encoder = JSONEncoder()
let decoder = JSONDecoder()

fileprivate enum TestJSONParse: String, CaseIterable {
    case handy, employ1, employ2, employ3, employ4, employ5, employ6, employ7, employ8
    case other
}

class ParseJsonViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        encoder.outputFormatting = .prettyPrinted
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        title = "解析json"
    }

    func jsonStr() -> String {
        let jsonStr = """
        {
            "ret_code": 0,
            "ret_msg": "Ok!",
            "request_id": "332819bba29e470a8b5657991fd725a2",
            "access_token": "FvgqJ2Og58wXUYNKDcOQ0+2VAbV2esyzyC02r2imyetkMZPBOe3FID9Xv9SI5RfB",
            "refresh_token": "7977efd2e5144dbc97eaa25c460b78ae",
            "expire_in": 34517,
            "nickname": "张三",
            "sex": "男",
            "province": "山东",
            "city": "淄博",
            "country": "中国",
            "headimgurl": "http://baidu.com?pic=123",
            "mobileNo": "13911223344",
            "userId": "1234556778888888888888",
            "school": {
                "schoolName": "北京四中",
                "schoolId": 13920
            },
            "class": {
                "className": "北京四中1班",
                "classId": 139203
            },
            "scoreList": [92,93,98,75],
            "subjectTuple": "语文_数学_英语"
        }
        """
        return jsonStr
    }
}

extension ParseJsonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TestJSONParse.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = TestJSONParse.allCases[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(c)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let c = TestJSONParse.allCases[indexPath.row]
        switch c {
        case .handy:
            let str = jsonStr()
            let userInfo = UserInfo.deserialize(from: str)
            log.info("userInfo = \(String(describing: userInfo))")

            let userInfoDic = userInfo?.toJSON()
            log.info("userInfoDic = \(String(describing: userInfoDic))")
            let userInfoString = userInfo?.toJSONString()

            let userInfo2 = UserInfo.deserialize(from: userInfoString)
            log.info("userinfo2 = \(String(describing: userInfo2))")
        case .employ1:
            log.info("employ1")
            let toy = Toy(name: "Teddy Bear")
            let employee = Employee1(name: "John Appleseed", id: 7, favoriteToy: toy)

            let data = try? encoder.encode(employee)
            let string = String(data: data!, encoding: .utf8)
            print("string = \(string ?? "null")")
            let sameEmployee = try? decoder.decode(Employee1.self, from: data!)
            log.info("sameEmployee = \(sameEmployee!)")

            let dic = sameEmployee?.dictionary
            log.info("dic = \(dic!)")

            // encoder 修改规则: 非驼峰（favoriteToy -> favorite_toy）
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data2 = try? encoder.encode(employee)
            let string2 = String(data: data2!, encoding: .utf8)
            print("string2 = \(string2 ?? "null")")

        case .employ2:
            log.info("employ2")
            let toy = Toy(name: "Teddy Bear")
            let employee = Employee2(name: "John Appleseed", id: 7, favoriteToy: toy)

            let data = try? encoder.encode(employee)
            let string = String(data: data!, encoding: .utf8)
            print("string = \(string ?? "null")")
            let sameEmployee = try? decoder.decode(Employee2.self, from: data!)
            log.info("sameEmployee = \(sameEmployee!)")
        case .employ3:
            let toy = Toy(name: "Teddy Bear")
            let employee = Employee3(name: "John Appleseed", id: 7, favoriteToy: toy)

            let data = try? encoder.encode(employee)
            let string = String(data: data!, encoding: .utf8)!
            let sameEmployee = try? decoder.decode(Employee3.self, from: data!)
            log.info("string = \(string)")
            log.info("sameEmployee = \(String(describing: sameEmployee))")
        case .employ4:
            let jsonStr = """
            {
              "name" : "John Appleseed",
              "id" : 7,
              "gift" : {
                "toy" : {
                  "name" : "Teddy Bear"
                }
              }
            }
"""
            let data = jsonStr.data(using: .utf8)
            let sameEmployee = try? decoder.decode(Employee4.self, from: data!)
            let data2 = try? encoder.encode(sameEmployee)
            let string = String(data: data2!, encoding: .utf8)!
            log.info("string = \(string)")
            
        case .employ5:
            encoder.dateEncodingStrategy = .formatted(.dateFormatter)
            decoder.dateDecodingStrategy = .formatted(.dateFormatter)
            
            let toy = Toy(name: "Teddy Bear")
            let employee = Employee5(name: "John Appleseed", id: 7, favoriteToy: toy, birthday: Date())

            let data = try? encoder.encode(employee)
            let string = String(data: data!, encoding: .utf8)
            print("string = \(string ?? "null")")
            let sameEmployee = try? decoder.decode(Employee5.self, from: data!)
            log.info("sameEmployee = \(sameEmployee!)")

            // 可以解码，只是时间不准确了
            let dic = sameEmployee?.dictionary
            log.info("dic = \(dic!)")
            
        case .employ6:
            let dateNoTimeFormatter = DateFormatter()
            dateNoTimeFormatter.dateFormat = "YYYY-MM-dd"
            
            encoder.dateEncodingStrategy = .formatted(dateNoTimeFormatter)
            decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                let container = try decoder.singleValueContainer()
                let dateStr = try container.decode(String.self)
                // possible date strings: "2016-05-01",  "2016-07-04T17:37:21.119229Z", "2018-05-20T15:00:00Z"
                let isoDateFormatter = DateFormatter()
                isoDateFormatter.calendar = Calendar(identifier: .iso8601)
                isoDateFormatter.locale = Locale(identifier: "en_US_POSIX")
                isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                isoDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
//                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
                
                let len = dateStr.count
                var date: Date? = nil
                if len == 10 {
                    date = dateNoTimeFormatter.date(from: dateStr)
                } else if len == 20 {
                    date = isoDateFormatter.date(from: dateStr)
                } else {
                    isoDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
                    date = isoDateFormatter.date(from: dateStr)
                }
                guard let date_ = date else {
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateStr)")
                }
                print("DATE DECODER \(dateStr) to \(date_)")
                return date_
            })
            
            let toy = Toy(name: "Teddy Bear")
            let employee = Employee5(name: "John Appleseed", id: 7, favoriteToy: toy, birthday: Date())
            log.info("employee = \(employee)")

            let data = try? encoder.encode(employee)
            let string = String(data: data!, encoding: .utf8)
            print("string = \(string ?? "null")")
            let sameEmployee = try? decoder.decode(Employee5.self, from: data!)
            log.info("sameEmployee = \(String(describing: sameEmployee))")
            
        case .employ8:
            let employee = Employee8(name: "John Appleseed", labels: ["teacher", "father"], id: 7, school: "7th Middle School")
            employee.gender = .female
//            let dic = employee.dictionary
//            print("emplayee = \(dic?.jsonString )")
            let data = try? encoder.encode(employee)
            let string = String(data: data!, encoding: .utf8)
            print("string = \(string ?? "null")")
            let sameEmployee = try? decoder.decode(Employee8.self, from: data!)
            log.info("sameEmployee = \(sameEmployee!)")
            
        default:
            log.info("default")
        }
    }
}

