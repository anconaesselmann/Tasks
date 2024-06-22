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
        let fruit = ["Feed the cats", "Let the chickens out", "Take out the trash", "Clean litter boxes", "Buy milk"]
        if interactive {
            let renderer = Renderer()
            var picker = Picker<SwiftCliPickerRow>(
                title: "Tasks",
                elements: fruit.map { .init(id: UUID(), title: $0 )}
            )
            var picker2 = Picker<SwiftCliPickerRow>(
                title: "Tasks",
                elements: fruit.map { .init(id: UUID(), title: $0 )}
            )
            renderer.start()
            renderer.add(view: picker)
            renderer.add(view: picker2)
            renderer.draw()
            renderer.run()
            renderer.stop()
        } else {
            for fruit in fruit {
                print(fruit)
            }
        }
    }
}
