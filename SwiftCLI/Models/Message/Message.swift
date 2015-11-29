//
//  Message.swift
//  SwiftCLI
//
//  Created by Anton Gregersen on 29/11/15.
//  Copyright © 2015 Anton Gregersen. All rights reserved.
//

import Foundation


class Message {
    
    let message: String
    let likeCount: Int
    let pageName: String
    let messageArray: Array<String>
    
    
    var isCO2: Bool
    var isOptimize: Bool
    
    init(message:String,likeCount:String,pageName: String) {
        self.message = message
        self.likeCount = Int(likeCount)!
        self.pageName = pageName
        self.messageArray = self.message.characters.split{$0 == " "}.map(String.init)
        self.isCO2 = false
        self.isOptimize = false
    }
}