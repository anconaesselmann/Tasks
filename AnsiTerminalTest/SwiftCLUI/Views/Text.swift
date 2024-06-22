//  Created by Axel Ancona Esselmann on 6/22/24.
//

import Foundation

struct Text: View {
    let content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        content
    }

    var width: Int {
        content.width
    }

    var height: Int {
        content.height
    }

    var string: String {
        content
    }
}
