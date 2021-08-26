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
    @State private var colorPickerShown = false
    @Binding var draggingElement: Bool
    @Binding var selectMode: SelectMode

    private let spacing: CGFloat = 40
    
    var body: some View {
        // Navigation View + 1 menu for 1 toolbar item?
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

                    Text(verbatim: "DrawMode: \(drawMode)")
                    Toggle("move element", isOn: self.$draggingElement)
                }
                HStack {
                    Text("Pencil width")
                        .padding()
                    Slider(value: $lineWidth, in: 1.0...15.0, step: 1.0)
                        .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Picker(selection:$drawMode, label: Text("Style")) {
                            ForEach(DrawMode.allCases, id: \.self) {
                                Text(verbatim: "\($0)")
                            }
                        }
                    }
                    label: {
                        Label("Shape", systemImage: "scribble.variable")
                    }
                }
                ToolbarItem(placement: .primaryAction, content: {
                    Menu {
                        Picker(selection:$selectMode, label: Text("Mode")) {
                            ForEach(SelectMode.allCases, id: \.self) {
                                Text(verbatim: "\($0)")
                            }
                        }
                    }
                    label: {
                        Label("Sort", systemImage: "filemenu.and.selection")
                    }
                })
                ToolbarItem(placement: .primaryAction, content: {
                    Menu {
                        Picker(selection:$color, label: Text("Color")) {
                            ForEach(ColorsProvider.supportedColors().map({ $0.color }), id: \.self) { color in
                                if let colorInfo = ColorsProvider.supportedColors().first(where: { $0.color == color }) {
                                    ColorEntry(colorInfo: colorInfo)
                                } else {
                                    Text(verbatim: "\(color)")
                                }
                            }
                        }
                    }
                    label: {
                        Label("Color", systemImage: "filemenu.and.selection")
                    }
                })
            }
        
        .frame(height: 200)
        .sheet(isPresented: $colorPickerShown, onDismiss: {
            self.colorPickerShown = false
        }, content: { () -> ColorPicker in
            ColorPicker(color: self.$color, colorPickerShown: self.$colorPickerShown)
        })
    }
}
