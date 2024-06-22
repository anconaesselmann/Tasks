//  Created by Axel Ancona Esselmann on 6/22/24.
//

import Foundation

struct HStack: View {

    var id: UUID = UUID()

    let elements: [any View]

    let spacing: Int

    var elementsChangedObserver: ElementsObserver

    init(spacing: Int = 1, _ elements: [any View]) {
        self.spacing = spacing
        self.elements = elements
        elementsChangedObserver = ElementsObserver()
        for view in elements {
            elementsChangedObserver.register(view)
        }
    }

    var body: some View {
        // TODO: Only works with one-line strings for now
        elements
            .map { $0.string }
            .joined(separator: Array(repeating: " ", count: spacing).joined())
    }

    var string: String {
        body.string
    }
}

import ANSITerminal

extension HStack: KeyPressObserver {
    
    func keyPressed(char: Character, key: (code: ANSITerminal.ANSIKeyCode, meta: [ANSITerminal.ANSIMetaCode])) -> Bool {
        for element in self.elements {
            if let observer = element as? KeyPressObserver {
                if observer.keyPressed(char: char, key: key) {
                    return true
                }
            }
        }
        return false
    }
}
