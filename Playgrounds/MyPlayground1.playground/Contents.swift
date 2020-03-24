import UIKit

extension Dictionary {
    var jsonStringRepresentation: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }

        return String(data: theJSONData, encoding: .ascii)
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

let dic2 = ["3-1": 111, "3-2": 222]
let dic:[String: Any] = ["2": "B", "1": "A", "3": dic2]

extension Foo {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}

struct Foo: Encodable{
    var a: Int
    var b: String
}

let foo = Foo(a: 1, b: "key1")
let b2 = foo.dictionary
print("b2 = \(b2!.jsonStringRepresentation!)")

//print(dic.jsonStringRepresentation!)
//let encoder = JSONEncoder()
//encoder.outputFormatting = .prettyPrinted
//if let jsonData = try? encoder.encode(dic) {
//    if let jsonString = String(data: jsonData, encoding: .ascii) {
//        print(jsonString)
//    }
//}

print("end")
