//  Created by Axel Ancona Esselmann on 6/21/24.
//

import Foundation
import SwiftCLUI

@main
struct TodoApp: App {

    let tasks = ["Feed the cats", "Let the chickens out", "Take out the trash", "Clean litter boxes", "Buy milk"]

    var body: some View {
        VStack(spacing: 2) {
            Text("Tasks app")
            Picker(elements: tasks)
        }
    }

    init() { }
}
