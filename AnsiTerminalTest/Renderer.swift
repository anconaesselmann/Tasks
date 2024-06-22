//  Created by Axel Ancona Esselmann on 6/22/24.
//

import Foundation
import ANSITerminal
import Combine

class Renderer {
    var views: [SwiftCLUIView] = []
    var restoreCursor: Int = 0
    var startingLine: Int = 0

    private var lines: [UUID: Int] = [:]

    var bag = Set<AnyCancellable>()

    func start() {
        cursorOff()
        restoreCursor = readCursorPos().row
        clearScreen()
        startingLine = readCursorPos().row
    }

    func add(view: SwiftCLUIView) {
        views.append(view)
        Mirror(reflecting: view).children.forEach { child in
            if let state = (child.value as? (any SwiftCLUIState)) {
                state.objectWillChange.sink { [weak self] in
                    guard let line = self?.lines[view.id] else {
                        return
                    }
                    view.update(at: line)
                }.store(in: &bag)
            }
        }
    }

    func draw() {
        var currentLine = startingLine + 1
        for view in views {
            lines[view.id] = currentLine
            var range = view.draw(at: currentLine)
            currentLine = range.upperBound
        }
    }

    func update() {
        for view in views {
            guard let currentLine = lines[view.id] else {
                continue
            }
            view.update(at: currentLine)
        }
    }

    func run() {
        while true {
            clearBuffer()
            if keyPressed() {
                let char = readChar()
                let key = readKey()
                for view in views {
                    guard let line = lines[view.id] else {
                        continue
                    }
                    if view.keyPressed(line, char: char, key: key) {
                        return
                    }
                }
            }
        }
    }

    func stop() {
        moveTo(restoreCursor - 1, 0)
    }
}
