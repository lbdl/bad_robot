//
//  FileReader.swift
//  BadRobot
//
//  Created by Timothy Storey on 23/08/2018.
//  Copyright © 2018 BITE-Software. All rights reserved.
//

import Foundation

struct InputReader {
        
    private func getInput() -> String? {
        print("Input path the Robot Command File", terminator: ": ")
        if let inputLine = readLine() {
            return inputLine
        } else {
            return nil
        }
    }
    
    private func testPath(_ fPath: String ) throws {
        let expandedString = fPath as NSString
        let pathStr = String(expandedString.expandingTildeInPath)
        
        if !FileManager.default.fileExists(atPath: pathStr) {
            throw FileReaderError.invalidPath(path: fPath)
        }
        
        if !FileManager.default.isReadableFile(atPath: pathStr) {
            throw FileReaderError.unreadableFile(path: pathStr)
        }
    }
    
    private func readFileFrom(_ path: String) throws -> Data? {
        let fURL = URL(fileURLWithPath:( path as NSString).expandingTildeInPath)
        
        do {
            let robotData = try Data(contentsOf: fURL)
            return robotData
        } catch {
            throw FileReaderError.dataReadError(error: "Could not convert file \(fURL.absoluteString)")
        }
    }
    
    func readRobotData() throws -> Data? {
        guard let dataPath = getInput() else { return nil}
        do {
            try testPath(dataPath)
            return try readFileFrom(dataPath)
        } catch {
            print(error)
            return nil
        }
    }
    
}

struct InputParser {
    
    var localString: String
    
    init(_ data: Data) {
        localString = data.toString()
    }
    
    func readGridData() throws -> PlanetGrid {
        
        let commandString = localString.split(separator: "\n")
        
        if (commandString.count % 2) != 1 {
            throw CommandParserError.IncorrectFileFormatError(msg: "Wrong length")
        }
        
        guard let gridLine = commandString.first else { throw CommandParserError.IncorrectGridData(msg: "") }
        let gridData = gridLine.split(separator: " ")
        return PlanetGrid(xMax: Int(gridData[0])!, yMax: Int(gridData[1])!)
    }
    
//    func readRobotsData () -> [Robot]
    
}
