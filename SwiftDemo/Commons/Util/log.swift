//
//  log.swift
//  SwiftDemo
//
//  Created by qianzhao on 2020/3/6.
//  Copyright © 2020 qianzhao. All rights reserved.
//

import Foundation

import SwiftyBeaver
let log = SwiftyBeaver.self

func initLog() -> Void {
    // add log destinations. at least one is needed!
    let console = ConsoleDestination()  // log to Xcode Console
    let file = FileDestination()  // log to default swiftybeaver.log file
    //
#if targetEnvironment(simulator)
    file.logFileURL = URL(fileURLWithPath: "/tmp/swiftybeaver_demo.log")
    print("filePath = \(file.logFileURL?.absoluteString ?? "null")")
#else
    let url = try? FileManager.default.url(for: .documentDirectory,
                                           in: .userDomainMask,
                                           appropriateFor: nil,
                                           create: true)
    let fileURL = url?.appendingPathComponent("debug.text")
    file.logFileURL = fileURL
    print("filePath = \(file.logFileURL?.absoluteString ?? "null")")
#endif
    
    //    let cloud = SBPlatformDestination(appID: "foo", appSecret: "bar", encryptionKey: "123") // to cloud
    /// log hour, minute and second, filename, function, line, log level & message
    /// console.format = "$DHH:mm:ss$d $N.$F():$l $L: $M"
    console.format = "$L $DHH:mm:ss$d $N $M"
    // or use this for JSON output: console.format = "$J"
    
    console.levelString.verbose = "🍓"
    console.levelString.info = "💜"
    console.levelString.debug = "🍏"
    console.levelString.warning = "⚠️"
    console.levelString.error = "❌"
    
    //    file.levelColor.verbose = "silver"
    //    file.levelColor.info = "green"
    //    file.levelColor.debug = "blue"
    //    file.levelColor.warning = "yellow"
    //    file.levelColor.error = "red"
    
    file.levelString.verbose = "🍓"
    file.levelString.info = "💜"
    file.levelString.debug = "🍏"
    file.levelString.warning = "⚠️"
    file.levelString.error = "❌"
    
    // add the destinations to SwiftyBeaver
    log.addDestination(console)
    log.addDestination(file)
    //    log.addDestination(cloud)
    //    testLog()
}

fileprivate func testLog() -> Void {
    // Now let’s log!
    log.verbose("not so important")  // prio 1, VERBOSE in silver
    log.debug("something to debug")  // prio 2, DEBUG in green
    log.info("a nice information")   // prio 3, INFO in blue
    log.warning("oh no, that won’t be good")  // prio 4, WARNING in yellow
    log.error("ouch, an error did occur!")  // prio 5, ERROR in red
    
    // log anything!
    log.verbose(123)
    log.info(-123.45678)
    log.warning(Date())
    log.error(["I", "like", "logs!"])
    log.error(["name": "Mr Beaver", "address": "7 Beaver Lodge"])
    
    log.debug("age", "123")  // "DEBUG: age 123"
    log.info("my data", context: [1, "a", 2]) // "INFO: my data [1, \"a\", 2]"
}
