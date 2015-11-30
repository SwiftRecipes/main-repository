//
//  Tasks.swift
//  SwiftCLI
//
//  Created by Anton Gregersen on 30/11/15.
//  Copyright © 2015 Anton Gregersen. All rights reserved.
//

import Foundation


class Tasks {
    
    static func unzipFile(path:String, callBack: (succes:Bool) -> Void) {
        let task = NSTask()
        task.launchPath = "/usr/bin/env"
        task.arguments = ["unzip", "\(path)", "-dtemp/"]
        
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = String(data: data, encoding: NSUTF8StringEncoding)!
        
        
        let lines = output.characters.split { $0 == "\n" || $0 == "\r\n" }.map(String.init)
        var folder = lines[2]
        folder = folder.stringByReplacingOccurrencesOfString("creating:", withString: "")
        folder = folder.stringByReplacingOccurrencesOfString(" ", withString: "")
        print("this is the folder: \(folder)")
        //from swiftcsv, should add to a string extension library!
        //output.splitOnNewLine()
        
        task.waitUntilExit()
        callBack(succes: true)
    }
    
}