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
    
    static func contentAtCurrentPath() -> [String] {
        let currentPath = NSFileManager.defaultManager().currentDirectoryPath
        let contentsAtPath = try! NSFileManager.defaultManager().contentsOfDirectoryAtPath(currentPath) as [String]
        return contentsAtPath
    }
    
    static func contentInTempDir() -> [String] {
        let currentPath = NSFileManager.defaultManager().currentDirectoryPath
        let contentsAtPath = try! NSFileManager.defaultManager().contentsOfDirectoryAtPath(currentPath + "/temp") as [String]
        return contentsAtPath
    }
    
    static func recipeFolderExists() -> Bool {
        let content = self.contentAtCurrentPath()
        let exists =  content.contains("recipes")
        return exists
    }
    
    static func tempFolderExists() -> Bool {
        let content = self.contentAtCurrentPath()
        let exists =  content.contains("temp")
        return exists
    }
    
    static func moveFolder(folder:String, toFolder destinationFolder:String) {
        let fileManager = NSFileManager.defaultManager()
        do {
            try fileManager.moveItemAtPath(folder, toPath: destinationFolder)
        } catch let error as NSError {
            print("error happened trying to move folder \(folder) to destination: \(destinationFolder) \n")
            print(error)
            exit(0)
        }
        
    }
    
    static func createRecipesFolder() {
        if (self.recipeFolderExists()) {
            return
        }
        print("Creating recipes folder")
        let path = self.currentDirectory() + "/recipes/"
        do {
            try NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
            print("error happened trying to create recipes folder")
        }
    }
    
    static func createTempFolder() {
        if (self.tempFolderExists()) {
            return //delete it?
        }
        print("Creating temp folder")
        let path = self.currentDirectory() + "/temp/"
        do {
            try NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
            print("error happened trying to create temp folder")
        }
    }
    
    static func deleteTempFolder() {
        do {
            try NSFileManager.defaultManager().removeItemAtPath(self.currentDirectory() + "/temp")
        } catch _ {
            print("error removing temp folder")
            exit(0)
        }
    }
    
    static func deleteDataInTemp() {
        do {
            try NSFileManager.defaultManager().removeItemAtPath(self.currentDirectory() + "/temp/data.zip")
        } catch _ {
            print("error deleting temp/data.zip")
            exit(0)
        }
        
    }
    
    
    
}