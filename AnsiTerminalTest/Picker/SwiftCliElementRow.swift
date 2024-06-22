//  Created by Axel Ancona Esselmann on 6/22/24.
//

import Foundation

protocol SwiftCliElementRow {
    var id: UUID { get }

    func draw(_ row: Int, _ col: Int)
}
