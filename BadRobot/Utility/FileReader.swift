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
    
    func readRobotsData (_ rawCommands: [String], robots: inout Array<Robot> ) {
        // assume that rawCommands has dropped off the first line with the grid data
        // lines are now 2 lines of data the start pos then the commands
        // so we want to use tail recursion, maybe we could get the same with reduce
        // but the data is \n separated so position newline commands
        if let nxt = rawCommands.first {
            let startRaw = nxt.split(separator: " ")
            let robotCoordinate = RobotCoord(direction: Dir(rawString: String(startRaw[2]))!, position: Pos(x: Int(startRaw[0])!, y: Int(startRaw[1])!))
            let cmds = rawCommands[1]
            let robot = Robot(sPos: robotCoordinate, cmds: cmds)
            robots.append(robot)
            let nextCommands = rawCommands.dropFirst(2)
            let commands = nextCommands.map { string in
                return String(string)
             }
            readRobotsData(commands, robots: &robots)
        } else {
            return
        }
    }
}
