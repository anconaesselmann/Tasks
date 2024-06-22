//  Created by Axel Ancona Esselmann on 6/22/24.
//

import Foundation
import Combine

internal protocol SwiftCLUIState {
    var objectWillChange: PassthroughSubject<Void, Never> { get }
}
