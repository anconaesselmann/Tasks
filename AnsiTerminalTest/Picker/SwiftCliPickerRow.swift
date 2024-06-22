//  Created by Axel Ancona Esselmann on 6/21/24.
//

import Foundation
import ANSITerminal

struct SwiftCliPickerRow: SwiftCLUIViewRow {
    let id: UUID

    var isActive: Bool = false

    var title: String

    func draw(_ line: Int, _ col: Int) {
        var title = isActive ? title : title.foreColor(8)
        var width = 50
        let paddingCount = max(0, width - title.count)
        var padding = ""
        if paddingCount > 0 {
            padding = Array(repeating: " ", count: paddingCount).joined()
        }

        moveTo(line, col)
        write((title + padding).backColor(214))
    }
}
