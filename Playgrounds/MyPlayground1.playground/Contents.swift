import UIKit

struct Student {
    var age: Int?
    var age2: Int?
//    var age3 : String?;
//    var age : String?;
}
func test(a: Int) -> String? {
    let c: String? = ""
    return c
}
var a: String! = ""
print("a1 = \(String(describing: a))")
a = "abcd"

let index: String.Index = a.index(after: a.startIndex)
print("aaa = \(a[index])")
print("a2 = \(String(describing: a))")

var c1 = MemoryLayout<Int>.size
print("c1 = \(c1)")

c1 = MemoryLayout<String>.size
print("c1 = \(c1)")

c1 = MemoryLayout<Character>.size
print("c1 = \(c1)")

c1 = MemoryLayout<Student>.size
print("c1 = \(c1)")

//var c:String? = ""
//a = c
//print("a3 = \(String(describing: a))")

//let b = a
//print("b = \(String(describing: b))")
//if b == nil {
//    print("aa")
//} else {
//    print("bb")
//}

print("end")
