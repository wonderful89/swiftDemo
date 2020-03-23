//
//  ParseJsonViewController.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/23.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import UIKit
import HandyJSON

enum UserSex:String, HandyJSONEnum {
    case male = "男"
    case female = "女"
}

class UserSchool: HandyJSON {
    var schoolName: String?
    var schoolId: Int?
    
    required init() {}
}

struct UserClass: HandyJSON {
    var className: String?
    var classId: Int?
}

class UserInfo: HandyJSON {
    var retCode: Int?
    var retMsg, requestID, accessToken, refreshToken: String?
    var expireIn: Int?
    var nickname,province, city: String?
    var sex: UserSex?
    var country: String?
    var headimgurl: String?
    var mobileNo, userID: String?
    var school: UserSchool?
    var classInfo: UserClass?
    var scoreList: [Int]?
    var subjectTuple: (String, String, String)?
    
    func mapping(mapper: HelpingMapper){
        // 指定 id 字段用 "cat_id" 去解析
        mapper.specify(property: &retCode, name: "ret_code")
        mapper.specify(property: &retMsg, name: "ret_msg")
        mapper.specify(property: &requestID, name: "request_id")
        mapper.specify(property: &accessToken, name: "access_token")
        mapper.specify(property: &refreshToken, name: "refresh_token")
        mapper.specify(property: &expireIn, name: "expire_in")
        mapper.specify(property: &userID, name: "userId")
        mapper.specify(property: &classInfo, name: "class")
        mapper.specify(property: &subjectTuple, name: "subjects") // 和下面的不能同时设置

        // 指定 subjectTuple 字段用这个方法去解析
        mapper.specify(property: &subjectTuple) { (rawString) -> (String, String, String) in
            let parentNames = rawString.split(separator: "_").map(String.init)
            return (parentNames[0], parentNames[1], parentNames[2])
        }
        
        mapper.specify(property: &mobileNo) { (rawString) -> (String) in
            return "135***"
        }
    }

    required init() {}
}

class BasicTypes: HandyJSON {
    var int: Int = 2
    var doubleOptional: Double?
    var stringImplicitlyUnwrapped: String!

    required init() {}
}


class ParseJsonViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "解析json"
        
        let str = jsonStr()
        let userInfo = UserInfo.deserialize(from: str)
        
        let userInfoJSONStr = userInfo?.toJSONString()
        
//        let jsonDecoder = JSONDecoder()
//        let dic = jsonDecoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
        
        log.info("dic = \(userInfoJSONStr)")
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
