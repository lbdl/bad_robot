//
//  Engine.swift
//  BadRobot
//
//  Created by Timothy Storey on 25/08/2018.
//  Copyright © 2018 BITE-Software. All rights reserved.
//

import Foundation

class Engine: NSObject {
    
    var robots: [Robot]
    var grid: PlanetGrid
    
    init(_ robots: [Robot], grid: PlanetGrid) {
        self.robots = robots
        self.grid = grid
        super.init()
    }

    func deployRobotArmy() {
        robots.forEach({bot in
            let runner = Driver(bot, flatEarth: grid)
            runner.run()
        })
    }

}

class Driver: NSObject {

    private var myBot: Robot
    private var diskWorld: PlanetGrid

    private func getNextDirection(_ dir: Dir, nxtMove: Move) -> Dir {
        switch nxtMove {
        case .L:
            let nxt = abs((dir.rawValue - 1) % 4)
            return Dir(rawValue: nxt)!
        case .R:
            let nxt = abs((dir.rawValue + 1) % 4)
            return Dir(rawValue: nxt)!
        case .F:
            return dir
        }
    }

    private func getNextCoordinate(_ move: Move, direction: Dir, position: Pos) -> Pos {
        switch move {
        case .F:
            switch direction {
            case .N:
                return Pos(x: position.x, y: position.y + 1)
            case .E:
                return Pos(x: position.x + 1, y: position.y)
            case .S:
                return Pos(x: position.x, y: position.y - 1)
            case .W:
                return Pos(x: position.x - 1, y: position.y)
            }
        case .L:
            return position
        case .R:
            return position
        }
    }

    private func didFallOffEdge(_ pos: RobotCoord) {

    }

    private func updatePosition(_ pos: RobotCoord, cmd: String) -> RobotCoord {
        let newDir = getNextDirection(pos.direction, nxtMove: Move(rawString: cmd)!)
        let newPosition = getNextCoordinate(Move(rawString: cmd)!, direction: newDir, position: pos.position)
        return RobotCoord(direction: newDir, position: newPosition)
    }

    private func runCommands(_ commands: inout String ) {
        if let cmd = commands.first {
            let newPos = updatePosition(myBot.currentPosition, cmd: String(cmd))
            let updatedBot = Robot(original: myBot, newPos: newPos, fPos: nil)
            myBot = updatedBot

            //did we fall off of the edge?
            //let valhallaCalls = didFallOffEdge(myBot.currentPosition)
            let newSeq = commands.dropFirst()
            var newCmds = String(newSeq)
            runCommands(&newCmds)
        } else {
            print("Robot final position: facing:\(myBot.currentPosition.direction) at:\(myBot.currentPosition.position)")
            return
        }
    }

    func run() {
        runCommands(&myBot.commands)
    }


    init(_ bot: Robot, flatEarth: PlanetGrid) {
        myBot = bot
        diskWorld = flatEarth
        super.init()
    }


}
