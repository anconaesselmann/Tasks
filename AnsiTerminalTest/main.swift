//  Created by Axel Ancona Esselmann on 6/21/24.
//

import Foundation
import ANSITerminal

func reRender(state: OptionState) {
    (state.rangeOfLines.minimum...state.rangeOfLines.maximum)
        .forEach { line in
            let isActive = line == state.activeLine
            let stateIndicator = isActive ? "●".lightGreen : "○".foreColor(250)
            writeAt(line, 3, stateIndicator)
            if let title = state.options.first(where: { $0.line == line })?.title {
                let title = isActive ? title : title.foreColor(250)
                writeAt(line, 5, title)
            }
        }
}

func picker(title: String, options: [String]) -> String {
    cursorOff()
    moveLineDown()
    write("◆".foreColor(81).bold)
    moveRight()
    write(title)

    let currentLine = readCursorPos().row + 1
    let state = OptionState(
        options: options.enumerated().map { Option(title: $1, line: currentLine + $0) },
        activeLine: currentLine,
        rangeOfLines: (currentLine, currentLine + options.count - 1)
    )

    options.forEach { optionTitle in
        moveLineDown()
        let isActive = readCursorPos().row == state.activeLine
        write("│".foreColor(81))
        moveRight()
        if isActive {
            write("●".lightGreen)
        } else {
            write("○".foreColor(250))
        }
        moveRight()
        if isActive {
            write(optionTitle)
        } else {
            write(optionTitle.foreColor(250))
        }
    }
    moveLineDown()
    let bottomLine = readCursorPos().row
    write("└".foreColor(81))

    while true {
        clearBuffer()
        if keyPressed() {
            let char = readChar()
            if let intValue = Int(String(char)) {
                let ranged = state.rangeOfLines.minimum + intValue
                if
                    ranged >= state.rangeOfLines.minimum,
                    ranged <= state.rangeOfLines.maximum
                {
                    state.activeLine = ranged
                    reRender(state: state)
                }
            } else {
                if char == NonPrintableChar.enter.char() {
                    break
                }
                let key = readKey()
                if key.code == .up {
                    if state.activeLine > state.rangeOfLines.minimum {
                        state.activeLine -= 1
                        reRender(state: state)
                    }
                } else if key.code == .down {
                    if state.activeLine < state.rangeOfLines.maximum {
                        state.activeLine += 1
                        reRender(state: state)
                    }
                }
            }
        }
    }
    let startLine = currentLine - 1
    writeAt(startLine, 0, "✔".green)

    (startLine + 1...bottomLine).forEach { writeAt($0, 0, "│".foreColor(252)) }

    moveTo(bottomLine, 0)

    let selection = state.options.first(where: { $0.line == state.activeLine })!.title
    print(selection)
    return selection
}

func writeAt(_ row: Int, _ col: Int, _ text: String) {
    moveTo(row, col)
    write(text)
}

_ = picker(title: "Choose your favourite fruit", options: ["🍌 Banana", "🥝 Kiwi", "🍓 Strawberry"])

