//  Created by Axel Ancona Esselmann on 6/21/24.
//

import Foundation
import ArgumentParser

struct Task: AsyncParsableCommand {

    public static let configuration = CommandConfiguration(
        abstract: "Lists taks"
    )

    @Flag(
        name: .shortAndLong,
        help: "Allows task selection with the cursor"
    )
    var interactive: Bool = false

    func run() throws {
        let tasks = ["Feed the cats", "Let the chickens out", "Take out the trash", "Clean litter boxes", "Buy milk"]
        if interactive {
            Renderer(
                VStack([
                    Picker(elements: tasks),
                ])
            ).run()
        } else {
            for task in tasks {
                print(task)
            }
        }
    }
}
