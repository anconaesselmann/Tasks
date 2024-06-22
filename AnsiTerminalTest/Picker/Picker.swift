//  Created by Axel Ancona Esselmann on 6/21/24.
//

import Foundation
import ANSITerminal
import Combine

struct Picker<Element>: SwiftCLUIView
    where Element: SwiftCLUIViewRow
{
    var id = UUID()
    
    private let title: String
    private let elements: [UUID: Element]
    private let order: [UUID]

    @State
    private var active: Int = 0

    init(title: String, elements: [Element]) {
        self.title = title
        self.elements = elements.reduce(into: [:]) {
            $0[$1.id] = $1
        }
        self.order = elements.map { $0.id }
    }

    func draw(at row: Int) -> Range<Int> {
        drawHeader(row)
        (contentStart(row)...contentEnd(row)).forEach { line in
            moveTo(line, 0)
            write("│".foreColor(81))
        }
        drawFooter(row)
        let _ = update(at: row)
        return row..<(footerStart(row) + 1)
    }

    func update(at line: Int) {
        for (index, id) in order.enumerated() {
            guard let element = elements[id] else {
                fatalError()
                continue
            }
            let line = contentStart(line) + index
            let stateIndicator = index == active
                ? "●".lightGreen
                : "○".foreColor(250)
            moveTo(line, 3)
            write(stateIndicator)
            element.draw(line, 5)
        }
    }

    func keyPressed(
        _ line: Int,
        char: Character,
        key: (code: ANSIKeyCode, meta: [ANSIMetaCode])
    ) -> Bool {
        if let intValue = Int(String(char)), intValue < elements.count {
            setActive(intValue)
            update(at: line)
        } else {
            if char == NonPrintableChar.enter.char() {
                return true
            }
            if key.code == .up {
                prevActive()
                update(at: line)
            } else if key.code == .down {
                nextActive()
                update(at: line)
            }
        }
        return false
    }

    private var titleHeight: Int {
        title.split(separator: "\n").count
    }

    private func contentStart(_ line: Int) -> Int {
        line + titleHeight
    }

    private func contentEnd(_ line: Int) -> Int {
        contentStart(line) + elements.count - 1
    }

    private func footerStart(_ line: Int) -> Int {
        contentEnd(line) + 1
    }

    private func drawHeader(_ line: Int) {
        moveTo(line, 0)
        write("◆".foreColor(81).bold)
        moveRight()
        write(title)
    }

    private func drawFooter(_ line: Int) {
        moveTo(footerStart(line), 0)
        write("└".foreColor(81))
    }

    private func nextActive() {
        active = min(order.count - 1, active + 1)
    }

    private func prevActive() {
        active = max(0, active - 1)
    }

    private func setActive(_ value: Int) {
        active = min(max(0, value), elements.count - 1)
    }
}
