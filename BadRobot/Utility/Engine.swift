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
        for bot in robots {
            let driver = Driver(bot, flatEarth: grid)
            driver.run()
        }
    }

}

struct Driver{

    var myBot: Robot
    var diskWorld: PlanetGrid

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

    private func didFallOffEdge(_ pos: RobotCoord) -> Bool {
        let freeFall = (pos.position.x < 0 || pos.position.x > diskWorld.maxX) || (pos.position.y > diskWorld.maxY || pos.position.y < 0)
        return freeFall
    }

    private func updatePosition(_ pos: RobotCoord, cmd: String) -> RobotCoord {
        let newDir = getNextDirection(pos.direction, nxtMove: Move(rawString: cmd)!)
        let newPosition = getNextCoordinate(Move(rawString: cmd)!, direction: newDir, position: pos.position)
        return RobotCoord(direction: newDir, position: newPosition)
    }

    private func runCommands(_ commands: inout String, curPos: inout RobotCoord ) {
        if let cmd = commands.first {
            var newPos = updatePosition(curPos, cmd: String(cmd))

            //did we fall off of the edge?
            if didFallOffEdge(newPos) {
                print("\(curPos.position.x)" + "\(curPos.position.y)" + "\(curPos.direction)" + " LOST")
                return
            }

            let newSeq = commands.dropFirst()
            var newCmds = String(newSeq)
            runCommands(&newCmds, curPos: &newPos)
        } else {
            print("\(curPos.position.x)" + "\(curPos.position.y)" + "\(curPos.direction)")
            return
        }
    }
    
    func run() {
        var commands = myBot.commands
        var startPosition = myBot.currentPosition
        runCommands(&commands, curPos: &startPosition)
    }


    init(_ bot: Robot, flatEarth: PlanetGrid) {
        myBot = bot
        diskWorld = flatEarth
    }


}
