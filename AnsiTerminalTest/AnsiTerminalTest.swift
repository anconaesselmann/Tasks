//  Created by Axel Ancona Esselmann on 6/21/24.
//

import Foundation
import ArgumentParser

@main
struct AnsiTerminalTest: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A test application for SwiftCLUI",
        subcommands: [
            Task.self
        ]
    )

    init() { }
}
