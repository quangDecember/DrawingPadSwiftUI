//
//  DrawingPad.swift
//  DrawingPadSwiftUI
//
//  Created by Martin Mitrevski on 20.07.19.
//  Copyright © 2019 Mitrevski. All rights reserved.
//

import SwiftUI

struct DrawingPad: View {
    @Binding var currentDrawing: Drawing
    @Binding var drawings: [Drawing]
    @Binding var color: Color
    @Binding var lineWidth: CGFloat
    @Binding var drawMode: DrawMode
    @Binding var draggingElement: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                ForEach(self.drawings, id: \.self){ drawingElement in
                    Path { path in
                        
                        self.add(drawing: drawingElement, toPath: &path)
                        
                    }
                    .stroke(drawingElement.color, lineWidth: self.lineWidth)
                }
                
                Path { path in
                    self.add(drawing: self.currentDrawing, toPath: &path)
                }
                .stroke(self.currentDrawing.color, lineWidth: self.lineWidth)
            }.background(Color(white: 0.95)).gesture(
                DragGesture(minimumDistance: 0.1)
                    .onChanged({ (value) in
                        if self.draggingElement {
                            return;
                        }
                        if self.currentDrawing.drawMode != self.drawMode {
                            self.currentDrawing.drawMode = drawMode
                        }
                        if self.currentDrawing.color != self.color {
                            self.currentDrawing.color = self.color
                        }
                        let currentPoint = value.location
                        if currentPoint.y >= 0
                            && currentPoint.y < geometry.size.height {
                            self.currentDrawing.points.append(currentPoint)
                        }
                    })
                    .onEnded({ (value) in
                        if self.draggingElement {
                            return;
                        }
                        self.drawings.append(self.currentDrawing)
                        self.currentDrawing = Drawing()
                    })
            )
        }
        .frame(maxHeight: .infinity)
    }
    
    private func add(drawing: Drawing, toPath path: inout Path) {
        let points = drawing.points
        if points.count > 1 {
            switch drawing.drawMode {
            case .freeStyle:
                for i in 0..<points.count-1 {
                    let current = points[i]
                    let next = points[i+1]
                    path.move(to: current)
                    path.addLine(to: next)
                }
            case .line:
                let current = points[0]
                let next = points.last!
                path.move(to: current)
                path.addLine(to: next)
            case .rectangle:
                let current = points[0]
                let next = points.last!
                let other1 = CGPoint(x: current.x, y: next.y)
                let other2 = CGPoint(x: next.x, y: current.y)
                path.move(to: current)
                path.addLine(to: other1)
                path.move(to: other1)
                path.addLine(to: next)
                path.move(to: next)
                path.addLine(to: other2)
                path.move(to: other2)
                path.addLine(to: current)
            case .rec2:
                let p1 = points[0]
                let p2 = points.last!
                let rect = CGRect(x: min(p1.x, p2.x),
                                  y: min(p1.y, p2.y),
                                  width: abs(p1.x - p2.x),
                                  height: abs(p1.y - p2.y));
                path.addRect(rect)
            case .eclipse:
                let p1 = points[0]
                let p2 = points.last!
                let rect = CGRect(x: min(p1.x, p2.x),
                                  y: min(p1.y, p2.y),
                                  width: abs(p1.x - p2.x),
                                  height: abs(p1.y - p2.y));
                path.addEllipse(in: rect)
            case .square:
                let p1 = points[0]
                let p2 = points.last!
                let edge = min(abs(p1.x - p2.x), abs(p1.y - p2.y))
                let rect = CGRect(x: min(p1.x, p2.x),
                                  y: min(p1.y, p2.y),
                                  width: edge,
                                  height: edge);
                path.addRect(rect)
            case .circle:
                let p1 = points[0]
                let p2 = points.last!
                let edge = min(abs(p1.x - p2.x), abs(p1.y - p2.y))
                let rect = CGRect(x: min(p1.x, p2.x),
                                  y: min(p1.y, p2.y),
                                  width: edge,
                                  height: edge);
                path.addEllipse(in: rect)
            }
        }
    }
    
}
