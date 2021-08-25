//
//  DrawingControls.swift
//  DrawingPadSwiftUI
//
//  Created by Martin Mitrevski on 19.07.19.
//  Copyright © 2019 Mitrevski. All rights reserved.
//

import SwiftUI

struct DrawingControls: View {
    @Binding var color: Color
    @Binding var drawings: [Drawing]
    @Binding var lineWidth: CGFloat
    @Binding var drawMode: DrawMode
    @State var internalDrawMode = DrawMode.freeStyle
    @State private var colorPickerShown = false

    private let spacing: CGFloat = 40
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: spacing) {
                    Button("Pick color") {
                        self.colorPickerShown = true
                    }
                    Button("Undo") {
                        if self.drawings.count > 0 {
                            self.drawings.removeLast()
                        }
                    }
                }
                HStack {
                    Button("Clear") {
                        self.drawings = [Drawing]()
                    }

                    Text(verbatim: "DrawMode: \(drawMode)").toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Menu {
                                Picker(selection:$drawMode, label: Text("Mode")) {
                                    ForEach(DrawMode.allCases, id: \.self) {
                                        Text(verbatim: "\($0)")
                                    }
                                }
                            }
                            label: {
                                Label("Sort", systemImage: "arrow.up.arrow.down")
                            }
                        }
                    }
                }
                HStack {
                    Text("Pencil width")
                        .padding()
                    Slider(value: $lineWidth, in: 1.0...15.0, step: 1.0)
                        .padding()
                }
            }

        }
        .frame(height: 200)
        .sheet(isPresented: $colorPickerShown, onDismiss: {
            self.colorPickerShown = false
        }, content: { () -> ColorPicker in
            ColorPicker(color: self.$color, colorPickerShown: self.$colorPickerShown)
        })
    }
}
