//
//  Recipe.swift
//  SwiftCLI
//
//  Created by Anton Gregersen on 29/11/15.
//  Copyright © 2015 Anton Gregersen. All rights reserved.
//

import Foundation

class Recipe {
    
    let name: String
    let source: String
    let version: String
    
    init(name:String, source: String, version: String) {
        self.name = name
        self.source = source
        self.version = version
    }
    
    init(dictionary:NSDictionary) {
        let json = JSON(dictionary)
        let sourceJSON = json["source"].dictionaryValue
        
        
        self.name = json["name"].stringValue
        self.version = json["version"].stringValue
        self.source = sourceJSON["git"]!.stringValue

    }
    
}

extension Recipe {
    func installRecipe() {
        //create folder.
        
        
    }
}