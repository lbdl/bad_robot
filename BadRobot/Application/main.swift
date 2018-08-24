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
    try parser.readGridData()
} catch {
    print(error)
}




