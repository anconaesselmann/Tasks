//  Created by Axel Ancona Esselmann on 6/22/24.
//

import Foundation
import SwiftCLUI

struct TodoApp: App {

    let body: VStack

    init(tasks: [String]) {
        body = VStack([
            Picker(elements: tasks),
        ])
    }
}
