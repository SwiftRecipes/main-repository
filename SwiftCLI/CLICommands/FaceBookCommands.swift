//
//  FaceBookCommands.swift
//  SwiftCLI
//
//  Created by Anton Gregersen on 29/11/15.
//  Copyright © 2015 Anton Gregersen. All rights reserved.
//

import Foundation

class FacebookCommand: CommandType {
    let commandName = "facebook"
    let commandShortDescription = "Run facebook command"
    let commandSignature = "" //<person>
    
    var messages = Array<Message>()
    
    
    func execute(arguments: CommandArguments) throws  {
        //do shit
        
        
        let filePath = FileManager.currentDirectory() + "/FBT_with_count_comment_info.csv"
        print(filePath)


        let inputString = try! String(contentsOfFile: filePath)
        let csv = CSwiftV(String: inputString)
        
        print(csv.headers)
        
        
        
        for (_,element) in csv.rows.enumerate() {
            let message = element[1]
            let likeCount = element[2]
            let pageName = element[8];
            let messageObj = Message(message: message, likeCount: likeCount, pageName: pageName)
            //print(messageObj.message)
            //print(messageObj.likeCount)
            //print("\(messageObj.pageName) \n")
            self.messages.append(messageObj)
        }
        
        
        self.computeRelevance()
        
        
    }
    
    
    func computeRelevance() {
        
        let optimizationArray = ["effektiv","effektivitet","mobilitet", "optimere", "optimering", "hastighed", "ubesværet", "bilkø", "trafikprop"]
        let co2Array = ["co2","klima","miljøvenlig", "grøn", "forurening"]

        //analyse each comment to see if words from either set exists
        for message in self.messages {
            //print(message.messageArray)
            let optiFoundList = optimizationArray.filter( { message.messageArray.contains($0) == true } )
            if (optiFoundList.count > 0) { //we found some...
                print("\(optiFoundList) \n")
                message.isOptimize = true
            } else {
                message.isOptimize = false
            }
            let co2FoundList = co2Array.filter( { message.messageArray.contains($0) == true } )
            if (co2FoundList.count > 0) { //we found some...
                print("\(co2FoundList) \n")
                message.isCO2 = true
            } else {
                message.isCO2 = false
            }
        }
        self.exportToCSV()
    }
    
    
    func exportToCSV(){
        
        print("start writing to file...")
        
        let fileName = FileManager.currentDirectory() + "/myFile.csv"
        //["comment_id", "comment_message", "comment_like_count", "comment_time_created", "comment_made_by_id", "comment_made_by_name", "post_id", "comment_made_to_id", "comment_made_to_name", "replies_count", "length_of_message", "tags_count", "id"]
        var data  = "comment_message,comment_like_count,comment_made_to_name,isEffect,isCO2\n"
        
        for message in self.messages {
            let messageString = message.message.stringByReplacingOccurrencesOfString(",", withString: "") + ","
            let like = "\(message.likeCount),"
            let pageName = message.pageName + ","
            let isOptimize = "\(message.isOptimize),"
            let isCO2 = "\(message.isCO2)\n"
            let complete = messageString + like + pageName + isOptimize + isCO2
            data.appendContentsOf(complete)
        }

        do {
            print("writing...")
            try data.writeToFile(fileName, atomically: false, encoding: NSUTF8StringEncoding)
        } catch _ {
            print("failed to write file ")
        }
        
        print("new csv file is complete")
        exit(0)
    }
    
    
}