//  Created by Axel Ancona Esselmann on 6/22/24.
//

import Foundation
import ANSITerminal

struct Picker: View, KeyPressObserver {

    @State
    var selected: Int = 0

    let elements: [String]

    var body: some View {
        VStack(
            elements.enumerated().map { (index, element) in
                HStack([
                    Text(index == selected
                     ? "●".lightGreen
                     : "○".foreColor(250)
                    ),
                    Text(element)
                ])
            }
        )
    }

    func keyPressed(
        char: Character,
        key: (code: ANSITerminal.ANSIKeyCode, meta: [ANSITerminal.ANSIMetaCode])
    ) -> Bool {
        if let intValue = Int(String(char)), intValue < elements.count {
            set(selected: intValue)
        } else {
            if char == NonPrintableChar.enter.char() {
                return true
            }
            if key.code == .up {
                previous()
            } else if key.code == .down {
                next()
            }
        }
        return false
    }

    private func next() {
        selected = min(elements.count - 1, selected + 1)
    }

    private func previous() {
        selected = max(0, selected - 1)
    }

    private func set(selected value: Int) {
        selected = min(max(0, value), elements.count - 1)
    }
}
