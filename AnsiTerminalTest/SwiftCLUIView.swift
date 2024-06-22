//  Created by Axel Ancona Esselmann on 6/22/24.
//

import Foundation
import ANSITerminal
import Combine

protocol SwiftCLUIView {
    var id: UUID { get }

    func draw(at row: Int) -> Range<Int>
    func update(at line: Int)
    func keyPressed(
        _ line: Int,
        char: Character,
        key: (code: ANSIKeyCode, meta: [ANSIMetaCode])
    ) -> Bool
}
