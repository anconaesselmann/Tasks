//  Created by Axel Ancona Esselmann on 6/21/24.
//

import Foundation
import ArgumentParser
import ANSITerminal

struct Fruit: AsyncParsableCommand {

    public static let configuration = CommandConfiguration(
        abstract: ""
    )

    @Flag(
        name: .shortAndLong,
        help: ""
    )
    var interactive: Bool = false

    func run() throws {
        cursorOff()
        let restoreCursor = readCursorPos().row
        clearScreen()
        let startingLine = readCursorPos().row
        let fruit = ["Feed the cats", "Let the chickens out", "Take out the trash", "Clean litter boxes", "Buy milk"]
        if interactive {
            var picker = Picker<SwiftCliPickerRow>(
                title: "Tasks",
                elements: fruit.map { .init(id: UUID(), title: $0 )}
            )
            picker.draw(at: startingLine + 1)
            while true {
                clearBuffer()
                if keyPressed() {
                    if picker.keyPressed() {
                        break
                    }
                }
            }
            moveTo(restoreCursor - 1, 0)
        } else {
            for fruit in fruit {
                print(fruit)
            }
        }
    }
}
