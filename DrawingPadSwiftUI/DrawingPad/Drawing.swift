//
//  Drawing.swift
//  DrawingPadSwiftUI
//
//  Created by Martin Mitrevski on 19.07.19.
//  Copyright © 2019 Mitrevski. All rights reserved.
//

import CoreGraphics
import SwiftUI

struct Drawing: Hashable {
    var drawMode: DrawMode = .freeStyle
    var points: [CGPoint] = [CGPoint]()
    var color = Color.black
}

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
