//  Created by Axel Ancona Esselmann on 6/22/24.
//

import Foundation
import Combine

@propertyWrapper class State<T>: SwiftCLUIState {

    var objectWillChange = PassthroughSubject<Void, Never>()
    
    var wrappedValue: T {
        didSet {
            objectWillChange.send()
        }
    }

    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}
