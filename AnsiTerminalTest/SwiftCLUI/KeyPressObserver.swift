//  Created by Axel Ancona Esselmann on 6/22/24.
//

import Foundation
import ANSITerminal

protocol KeyPressObserver {
    func keyPressed(
        char: Character,
        key: (code: ANSITerminal.ANSIKeyCode, meta: [ANSITerminal.ANSIMetaCode])
    ) -> Bool
}
