//
//  FileManager.swift
//  SwiftCLI
//
//  Created by Anton Gregersen on 29/11/15.
//  Copyright © 2015 Anton Gregersen. All rights reserved.
//

import Foundation


class FileManager {
    
    static func currentDirectory() -> String {
        let currentPath = NSFileManager.defaultManager().currentDirectoryPath
        return currentPath
    }
    
    
    static func createFolderInCurrentDir(folderName:String) {
        let currentPath = NSFileManager.defaultManager().currentDirectoryPath + "/\(folderName)"
        try! NSFileManager.defaultManager().createDirectoryAtPath(currentPath, withIntermediateDirectories: false, attributes: nil)
        
    
    }
    
    static func contentAtCurrentPath() {
        let currentPath = NSFileManager.defaultManager().currentDirectoryPath
        let contentsAtPath = try! NSFileManager.defaultManager().contentsOfDirectoryAtPath(currentPath) as [String]
        for contentItem in contentsAtPath
        {
            print(contentItem)
        }
    }
    
    
}