//
//  main.swift
//  SwiftCLI
//
//  Created by Anton Gregersen on 29/11/15.
//  Copyright © 2015 Anton Gregersen. All rights reserved.
//

import Foundation

let debug = false


//Setup
CLI.setup(name: "SwiftCLI", version: "0.1", description: "Swift recipes - your dependency and package manager for pure Swift")

//Register commands
//Global
CLI.registerCommand(UpgradeCommand())

//Local (project scope)
CLI.registerCommand(UpdateCommand())
CLI.registerCommand(InitCommand())
CLI.registerCommand(InstallCommand())
CLI.registerCommand(TestGetJson())
CLI.registerCommand(CurrentDirCommand())
CLI.registerCommand(FacebookCommand())
CLI.registerCommand(TestDownload())

//Go or Debug
if debug {
    CLI.debugGoWithArgumentString("SwiftCLI facebook")
} else {
    CLI.go()
}
//



func main() {
    //Keep program alive until exit(0) is called.
    while(true){}
}
main()