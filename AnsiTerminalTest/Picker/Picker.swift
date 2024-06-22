//  Created by Axel Ancona Esselmann on 6/21/24.
//

import Foundation
import ANSITerminal

struct Picker<Element>
    where Element: SwiftCliElementRow
{
    private let title: String
    private let elements: [UUID: Element]
    private var active: Int = 0
    private var line: Int = 0

    private var titleHeight: Int {
        title.split(separator: "\n").count
    }

    private var contentStart: Int {
        line + titleHeight
    }

    private var contentEnd: Int {
        contentStart + elements.count - 1
    }

    private var order: [UUID] = []

    init(title: String, elements: [Element]) {
        self.title = title
        self.elements = elements.reduce(into: [:]) {
            $0[$1.id] = $1
        }
        self.order = elements.map { $0.id }
    }

    private func drawHeader() {
        moveTo(line, 0)
        write("◆".foreColor(81).bold)
        moveRight()
        write(title)
    }

    private func drawFooter() {
        let row = line + contentEnd - 1
        moveTo(row, 0)
        write("└".foreColor(81))
    }

    mutating func draw(at row: Int) {
        self.line = row
        drawHeader()
        (contentStart...contentEnd).forEach { line in
            moveTo(line, 0)
            write("│".foreColor(81))
        }
        drawFooter()
        let _ = update()
    }

    func update() {
        let row = contentStart
        for (index, id) in order.enumerated() {
            guard let element = elements[id] else {
                fatalError()
                continue
            }
            let line = row + index
            let stateIndicator = index == active ? "●".lightGreen : "○".foreColor(250)
            moveTo(line, 3)
            write(stateIndicator)
            element.draw(line, 5)
        }
    }

    mutating func keyPressed() -> Bool {
        let char = readChar()
        if let intValue = Int(String(char)), intValue < elements.count {
            setActive(intValue)
            update()
        } else {
            if char == NonPrintableChar.enter.char() {
                return true
            }
            let key = readKey()
            if key.code == .up {
                prevActive()
                update()
            } else if key.code == .down {
                nextActive()
                update()
            }
        }
        return false
    }

    private mutating func nextActive() {
        active = min(order.count - 1, active + 1)
    }

    private mutating func prevActive() {
        active = max(0, active - 1)
    }

    private mutating func setActive(_ value: Int) {
        active = min(max(0, value), elements.count - 1)
    }
}
