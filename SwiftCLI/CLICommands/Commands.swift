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
        GitManager.retreiveRecipeInfo("TestLibrary", version: "1.0", callBack: { (recipe) -> Void in
            print(recipe.name)
            print(recipe.version)
            print(recipe.source)
            
            
            exit(0)
        })
    }
}

class TestDownload: CommandType {
    let commandName = "download"
    let commandShortDescription = "Test download"
    let commandSignature = "" //<person>
    
    func execute(arguments: CommandArguments) throws  {
        GitManager.retreiveRecipe("aURL") { (data) -> Void in
            FileManager.createTempFolder()
            
            let path = FileManager.currentDirectory() + "/temp/data.zip"
            data.writeToFile(path, atomically: true)
            
            Tasks.unzipFile("temp/data.zip", callBack: { (succes) -> Void in
                if succes { //success not implemented, always returns true!
                    print("unzip successfull")
                } else {
                    print("unzip unsuccessfull")
                }
            })
            
            //delete data.zip
            FileManager.deleteDataInTemp()
            //create recipe folder, if it doesnt exist.
            FileManager.createRecipesFolder()
            //move repository to recipe folder.
            let contentInTemp = FileManager.contentInTempDir()
            if contentInTemp.count > 1 {
                print("too many folder in temp, something went wront")
                exit(0)
            }
            let repoName = contentInTemp.first
            guard let repoFolderName = repoName else {
                print("Repo folder name is empty, something went wrong")
                exit(0)
            }
            let folder = FileManager.currentDirectory() + "/temp/\(repoFolderName)/"
            let desination = FileManager.currentDirectory() + "/recipes/\(repoFolderName)"
            FileManager.moveFolder(folder, toFolder: desination)
            
            //delete temp dir
            FileManager.deleteTempFolder()
            
            exit(1)
        }
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