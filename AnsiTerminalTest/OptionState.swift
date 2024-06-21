//  Created by Axel Ancona Esselmann on 6/21/24.
//

import Foundation

class OptionState {
    let options: [Option]
    let rangeOfLines: (minimum: Int, maximum: Int)
    var activeLine: Int = .zero

    init(options: [Option], activeLine: Int, rangeOfLines: (minimum: Int, maximum: Int)) {
        self.activeLine = activeLine
        self.rangeOfLines = rangeOfLines
        self.options = options
    }
}
