//
//  main.swift
//  BadRobot
//
//  Created by Timothy Storey on 23/08/2018.
//  Copyright © 2018 BITE-Software. All rights reserved.
//

import Foundation

enum FileReaderError: Error {
    case invalidPath(path: String)
    case unreadableFile(path: String)
    case invalidFormat
}

struct InputReader {
    
    func getInput() -> String? {
        print("Input path the Robot Command File", terminator: ": ")

        if let inputLine = readLine() {
            return inputLine
        } else {
            return nil
        }
    }
    
    func testPath(_ fPath: String ) throws {
        let expandedString = fPath as NSString
        let pathStr = String(expandedString.expandingTildeInPath)
        
        if !FileManager.default.fileExists(atPath: pathStr) {
            throw FileReaderError.invalidPath(path: fPath)
        }
        
        if !FileManager.default.isReadableFile(atPath: pathStr) {
            throw FileReaderError.unreadableFile(path: pathStr)
        }
    }
    
    
}


struct InputParser {
    
}

let reader = InputReader()

