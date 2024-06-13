// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Foundation
import MyCTool

//let myCStringPointer = UnsafePointer<CChar>(myCString)
//
//@_used 
//@_section("__DATA,__rhea_section")
//let my_global1: Int = 42
//
//@_used
//@_section("__DATA,__rhea_section")
//let my_global2: Int = 46
//
//@_silgen_name(raw: "section$start$__DATA$__rhea_section")
//var mysection_start: Int
//
//@_silgen_name(raw: "section$end$__DATA$__rhea_section")
//var mysection_end: Int
//
//
//@main
//struct Main {
//    static func main() {
//        let start = UnsafeRawPointer(&mysection_start)
//        let end = UnsafeRawPointer(&mysection_end)
//        let size = end - start
//        let count = size / (Int.bitWidth / 8)
//        print("count: \(count)")
//        let linker_set = UnsafeBufferPointer(start: start.bindMemory(to: Int.self, capacity: count), count: count)
//        for i in 0 ..< linker_set.count {
//            print("mysection[\(i)]: \(linker_set[i])")
//        }
//    }
//}

// CHECK: count: 2
// CHECK: mysection[0]: 42
// CHECK: mysection[1]: 46


/*
 1: 17
 2: 41  24
 3: 65  24
 4: 89  24
 5: 113  24
 */

//@_used
//@_section("__DATA,__mysection")
//let my_global1: StaticString = "ss:11"
//
//@_used
//@_section("__DATA,__mysection")
//let my_global2: StaticString = "ss:22"
//
//@_used
//@_section("__DATA,__mysection")
//let my_global3: StaticString = "ss:33"
//
//@_used
//@_section("__DATA,__mysection")
//let my_global4: StaticString = "ss:asfasfasf3fqwsdgasdf23rfqwegasdgaqef23tfgsdgasfasdfasdf34gsadgasfasdf234trasdgfasdfasdfasdfasdfasdf"
//
//@_used
//@_section("__DATA,__mysection")
//let my_global5: StaticString = "ss:55"
//
//@_silgen_name(raw: "section$start$__DATA$__mysection")
//var mysection_start: Int
//
//@_silgen_name(raw: "section$end$__DATA$__mysection")
//var mysection_end: Int
//
//@main
//struct Main {
//    static func main() {
//        let start = UnsafeRawPointer(&mysection_start)
//        let end = UnsafeRawPointer(&mysection_end)
//        let size = end - start
//        
//        var count = 0
//        let staticStringSize = MemoryLayout<StaticString>.size
//        let staticStringStride = MemoryLayout<StaticString>.stride
//        if size == staticStringSize {
//            count = 1
//        } else {
//            count = 1 + (size - staticStringSize) / staticStringStride
//        }
//        print("size: \(size)")
//        if size > 0 {
//            print(MemoryLayout<Unicode.Scalar>.size)
//            print("layout size: \(MemoryLayout<StaticString>.size)")
//            print("layout stride: \(MemoryLayout<StaticString>.stride)")
//            
//            let staticStrings = start.bindMemory(to: StaticString.self, capacity: count)
//            let buffer = UnsafeBufferPointer(start: staticStrings, count: count)
//
//            for staticString in buffer {
//                print(staticString)
//            }
//        }
//    }
//}


struct Test {
    func foo() {
        print("i am test")
    }
}

let globalTest = Test()

typealias FuncType = () -> Void

@_used
@_section("__DATA,__mysection") let a: FuncType = {
    print("~~~~~~my function called")
    Test().foo()
    globalTest.foo()
}

@_used
@_section("__DATA,__mysection") let b: FuncType = {
    print("~~~~~~vvvvvvv gbbb my function called")
}

@_silgen_name(raw: "section$start$__DATA$__mysection")
var mysection_start: Int

@_silgen_name(raw: "section$end$__DATA$__mysection")
var mysection_end: Int

@main
struct Main {
    static func main() {
        let start = UnsafeRawPointer(&mysection_start)
        let end = UnsafeRawPointer(&mysection_end)
        let size = end - start

        var count = 0
        let typeSize = MemoryLayout<FuncType>.size
        let typeStride = MemoryLayout<FuncType>.stride
        if size == typeSize {
            count = 1
        } else {
            count = 1 + (size - typeSize) / typeStride
        }
        
        print("size: \(size)")
        if size > 0 {
            let function = start.bindMemory(to: FuncType.self, capacity: count)
            let buffer = UnsafeBufferPointer(start: function, count: count)

            for function in buffer {
                function()
            }
        }

    }
}
