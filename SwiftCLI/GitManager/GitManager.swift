//
//  GitManager.swift
//  SwiftCLI
//
//  Created by Anton Gregersen on 29/11/15.
//  Copyright © 2015 Anton Gregersen. All rights reserved.
//

import Foundation


class GitManager {
    
    static func retreiveRecipe(name:String,version:String, callBack: Recipe -> Void) {
        
        let endPoint = "https://raw.githubusercontent.com/SwiftRecipes/main-repository/master/recipes/\(name)/\(version)/\(name).recipe.json"
        guard let url = NSURL(string: endPoint) else {
            print("Error: cannot create URL")
            exit(0)
        }
        
        let urlRequest = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            guard let responseData = data else {
                print("Error: did not receive data")
                exit(0)
            }
            
            let dictionary: NSDictionary
            do {
                dictionary = try NSJSONSerialization.JSONObjectWithData(responseData,options: []) as! NSDictionary
            } catch  {
                print("error trying to convert data to JSON")
                exit(0)
            }
            let recipe = Recipe(dictionary: dictionary)
            callBack(recipe);
        }
        task.resume()
    }
    
    
}