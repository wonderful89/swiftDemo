import UIKit

extension Dictionary {
    var jsonStringRepresentation: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }

        let str = String(data: theJSONData, encoding: .utf8)
//        [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        let policyStr = str!.replacingOccurrences(of: "\\", with: "")
        return policyStr
    }
}

struct Student {
    var age: Int?
    var age2: Int?
//    var age3 : String?;
//    var age : String?;
}

let a: String?

a = nil

let b = a?.isEmpty ?? true
print("b2 = \(b)")

let now = Date()
print("date = \(now)")

let dic2:[String :Any] = ["aaaa": "http://baidu.com/afa/fds/test.png", "3-2": 222]
//let dic:[String: Any] = ["2": "B", "1": "A", "3": dic2]

print("dic2 = \(dic2.jsonStringRepresentation!)")

guard let url1 = dic2["aaaa"]  else {
    print("else....")
    exit(0)
}

print("url1 = \(url1)")

//print(dic.jsonStringRepresentation!)
//let encoder = JSONEncoder()
//encoder.outputFormatting = .prettyPrinted
//if let jsonData = try? encoder.encode(dic) {
//    if let jsonString = String(data: jsonData, encoding: .ascii) {
//        print(jsonString)
//    }
//}

print("end")
