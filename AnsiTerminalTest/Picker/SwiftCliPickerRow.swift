//  Created by Axel Ancona Esselmann on 6/21/24.
//

import Foundation
import ANSITerminal

struct SwiftCliPickerRow: SwiftCliElementRow {
    let id: UUID

    var isActive: Bool = false

    var title: String

    func draw(_ line: Int, _ col: Int) {
        let title = isActive ? title : title.foreColor(250)
        moveTo(line, col)
        write(title)
    }
}
