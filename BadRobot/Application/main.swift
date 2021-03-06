//
//  main.swift
//  BadRobot
//
//  Created by Timothy Storey on 23/08/2018.
//  Copyright © 2018 BITE-Software. All rights reserved.
//

import Foundation

let reader = InputReader()

do {
    let data = try reader.readRobotData()
    let parser = InputParser(data!)
    let grid = try parser.readGridData()

    let robotsSlices = parser.localString.split(separator: "\n").dropFirst()

    // drop the grid data and build some robots
    let commandsArray = robotsSlices.map { substring -> String in
        return String(substring)
     }

    var robotArray = Array<Robot>()
    parser.readRobotsData(commandsArray, robots: &robotArray)

    let engine = Engine(robotArray, grid: grid)
    engine.deployRobotArmy()

} catch {
    print(error)
}




