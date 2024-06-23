//  Created by Axel Ancona Esselmann on 6/21/24.
//

import Foundation
import SwiftCLUI

@main
struct TodoApp: App {

    var body: VStack

    init() {
        let tasks = ["Feed the cats", "Let the chickens out", "Take out the trash", "Clean litter boxes", "Buy milk"]
        body = VStack(spacing: 2) {
            Text("Tasks app")
            Picker(elements: tasks)
        }
    }
}
