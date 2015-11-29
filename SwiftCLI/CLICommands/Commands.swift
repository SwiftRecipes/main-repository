//
//  Commands.swift
//  SwiftCLI
//
//  Created by Anton Gregersen on 29/11/15.
//  Copyright © 2015 Anton Gregersen. All rights reserved.
//

import Foundation


class UpgradeCommand: CommandType {
    
    let commandName = "upgrade"
    let commandShortDescription = "Upgrades \(projectName) to fetch newest module information - must be done before first init."
    let commandSignature = "" //<person>
    
    func execute(arguments: CommandArguments) throws  {
        //let person = arguments.requiredArgument("person")
        print("Upgrading \(projectName)")
    }
}

class WipeCommand: CommandType {
    
    let commandName = "wipe"
    let commandShortDescription = "Wipes \(projectName) global database and information"
    let commandSignature = "" //<person>
    
    func execute(arguments: CommandArguments) throws  {
        //let person = arguments.requiredArgument("person")
        print("Wiping global recipe database, you will need to do a upgrade before init or update")
    }
}


class CleanCommand: CommandType {
    
    let commandName = "clean"
    let commandShortDescription = "Clean the current project folder - removing all recipes that have been installed."
    let commandSignature = "" //<person>
    
    func execute(arguments: CommandArguments) throws  {
        //let person = arguments.requiredArgument("person")
        print("Removing all recipes from this project")
    }
}

class UpdateCommand: CommandType {
    
    let commandName = "update"
    let commandShortDescription = "Updates the modules"
    let commandSignature = "" //<person>
    
    func execute(arguments: CommandArguments) throws  {
        //let person = arguments.requiredArgument("person")
        print("Updating the module")
    }
}

class InitCommand: CommandType {
    
    let commandName = "init"
    let commandShortDescription = "Initialize the recipe"
    let commandSignature = "" //<person>
    
    func execute(arguments: CommandArguments) throws  {
        //let person = arguments.requiredArgument("person")
        print("Updating the module")
    }
}

class TestGetJson: CommandType {
    
    let commandName = "json"
    let commandShortDescription = "Test command to get a json-file"
    let commandSignature = "" //<person>
    
    func execute(arguments: CommandArguments) throws  {
        GitManager.retreiveRecipe("TestLibrary", version: "1.0", callBack: { (recipe) -> Void in
            print(recipe.name)
            print(recipe.version)
            print(recipe.source)
            
            FileManager.createFolderInCurrentDir("test")
            print("The current directory is \(FileManager.currentDirectory())")
            exit(0)
        })
    }
}

class CurrentDirCommand: CommandType {
    
    let commandName = "currentDir"
    let commandShortDescription = "Prints out current directory"
    let commandSignature = ""
    
    
    func execute(arguments: CommandArguments) throws  {
        print(FileManager.currentDirectory())
        exit(0)
    }
}


class InstallCommand: CommandType {
    
    let commandName = "install"
    let commandShortDescription = "install recipes defined in config file, or install a recipe from argument. Fx. 'install sqlliteSwift'"
    let commandSignature = "[<module>]"
    
    
    func execute(arguments: CommandArguments) throws  {
        let module = arguments.optionalArgument("module")

        
        if let unwrappedModule = module {
            print("Installing \(unwrappedModule)")
        } else {
            print("no module specified, will install from config-file")
        }
    }
}