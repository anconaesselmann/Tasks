//  Created by Axel Ancona Esselmann on 6/22/24.
//

import Foundation
import Combine

@propertyWrapper class State<T>: SwiftCLUIState {
    var wrappedValue: T {
        didSet {
            objectWillChange.send()
        }
    }

    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }

    var objectWillChange = PassthroughSubject<Void, Never>()
}

protocol SwiftCLUIState {
    var objectWillChange: PassthroughSubject<Void, Never> { get }
}
