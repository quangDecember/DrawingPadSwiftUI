//
//  UtilsExtension.swift
//  DrawingPadSwiftUIMac
//
//  Created by Quang on 8/25/21.
//  Copyright © 2021 Mitrevski. All rights reserved.
//

import Foundation
#if os(iOS)
import CoreGraphics
#endif

extension CGPoint {
    func moveWithVector(originPoint: CGPoint, endPoint: CGPoint) -> CGPoint {
        var newP = CGPoint()
        newP.x = self.x + endPoint.x - originPoint.x
        newP.y = self.y + endPoint.y - originPoint.y
        return newP
    }
}
