//
//  Data+String.swift
//  BadRobot
//
//  Created by Timothy Storey on 24/08/2018.
//  Copyright © 2018 BITE-Software. All rights reserved.
//

import Foundation

extension Data {
    func toString() -> String {
        return String(data: self, encoding: .utf8)!
    }
}
