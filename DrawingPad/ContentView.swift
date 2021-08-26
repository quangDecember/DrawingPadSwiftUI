//
//  ContentView.swift
//  DrawingPadSwiftUI
//
//  Created by Martin Mitrevski on 20.07.19.
//  Copyright © 2019 Mitrevski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var currentDrawing: Drawing = Drawing()
    @State private var drawings: [Drawing] = [Drawing]()
    @State private var color: Color = Color.black
    @State private var lineWidth: CGFloat = 3.0
    @State private var drawingMode = DrawMode.freeStyle
    @State private var draggingElement = false
    @State private var selectMode = SelectMode.copy
    
    var body: some View {
        VStack(alignment: .center) {
            #if os(macOS)
            Text("Draw something")
                .font(.largeTitle)
            #endif
            DrawingPad(currentDrawing: $currentDrawing,
                       drawings: $drawings,
                       color: $color,
                       lineWidth: $lineWidth,
                       drawMode: $drawingMode,
                       draggingElement: $draggingElement,
                       selectMode: $selectMode
            )
            DrawingControls(color: $color, drawings: $drawings, lineWidth: $lineWidth, drawMode: $drawingMode, draggingElement: $draggingElement, selectMode: $selectMode)
        }
    }
}
