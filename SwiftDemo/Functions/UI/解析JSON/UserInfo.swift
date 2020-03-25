//
//  UserInfo.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/25.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation
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

//extension UserInfo: Codable{
//
//    enum CodingKeys: String, CodingKey {
//        case userId
//        case retCode
//        case retMsg
//    }
//
//    enum AdditionalInfoKeys: String, CodingKey {
//        case elevation
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(userID, forKey: .userId)
//        try container.encode(retCode, forKey: .retCode)
//    }
//
////    init(from decoder: Decoder) throws {
////        userID = try decoder.decode(Double.self, forKey: .userId)
////    }
//}

class BasicTypes: HandyJSON {
    var int: Int = 2
    var doubleOptional: Double?
    var stringImplicitlyUnwrapped: String!

    required init() {}
}
