//
//  Employee.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/25.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation

protocol ToDicProtocol: Codable {
    var dictionary: [String: Any]? { get }
}

extension ToDicProtocol {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

struct Toy: Codable {
    var name: String
}

struct Employee1: Codable, ToDicProtocol {
    var name: String
    var id: Int
    var favoriteToy: Toy
}

// 自定义JSON Key
struct Employee2: Codable {
    var name: String
    var id: Int
    var favoriteToy: Toy
    enum CodingKeys: String, CodingKey {
        case name, id, favoriteToy = "gift"
    }
}

// 自定义方法
struct Employee3: Encodable {
    var name: String
    var id: Int
    var favoriteToy: Toy

    enum CodingKeys: CodingKey {
        case name, id, gift
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self) // 声明一个container，可以像Dictionory用指定键存储内容

        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(favoriteToy.name, forKey: .gift) // 关键：指定key为gift去encode favoriteToy的内容
    }
}

// 写在extension里是为了保持Swift struct的member-wise initializer， 如果在struct的主定义里写了init方法就会导致失效
extension Employee3: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)

        let gift = try container.decode(String.self, forKey: .gift)
        favoriteToy = Toy(name: gift)
    }
}

// Deep JSON
struct Employee4: Encodable {
    var name: String
    var id: Int
    var favoriteToy: Toy

    enum CodingKeys: CodingKey {
        case name, id, gift
    }

    enum GiftKeys: CodingKey {
        case toy
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        // 在外层container基础上声明嵌套container
        var giftContainer = container.nestedContainer(keyedBy: GiftKeys.self, forKey: .gift)
        try giftContainer.encode(favoriteToy, forKey: .toy)
    }
}

extension Employee4: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        // 从外层container中获取嵌套container
        let giftContainer = try container.nestedContainer(keyedBy: GiftKeys.self, forKey: .gift)
        favoriteToy = try giftContainer.decode(Toy.self, forKey: .toy)
    }
}

// date 格式
extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
}

struct Employee5: Codable, ToDicProtocol {
    var name: String
    var id: Int
    var favoriteToy: Toy
    var birthday: Date
}

// : Codable, ToDicProtocol
class Employee7: Codable, ToDicProtocol {
    var name: String?
    var id: Int
    var labels: [String]

    init(name: String, id: Int, labels: [String]) {
        self.name = name
        self.id = id
        self.labels = labels
    }
}

//性别的枚举
enum Gender: Int, Codable {
    case male    //男性
    case female  //女性
    case unknow  //未知
}


class Employee8: Employee7 {
    var school: String?
    var gender: Gender?

    enum CodingKeys: CodingKey {
        case school, gender
    }
    
    init(name: String, labels: [String], id: Int, school: String){
        super.init(name: name, id: id, labels: labels)
        self.school = school
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        school = try? container.decode(String.self, forKey: .school)
        gender = try? container.decode(Gender.self, forKey: .gender)
        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(school, forKey: .school)
        try container.encode(gender, forKey: .gender)
        try super.encode(to: encoder)
    }
}
