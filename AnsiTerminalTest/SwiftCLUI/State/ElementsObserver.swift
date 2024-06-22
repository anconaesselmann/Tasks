//  Created by Axel Ancona Esselmann on 6/22/24.
//

import Foundation
import Combine

class ElementsObserver: SwiftCLUIState {

    var objectWillChange = PassthroughSubject<Void, Never>()

    var bag = Set<AnyCancellable>()

    func register(_ view: some View) {
        Mirror(reflecting: view).children.forEach { child in
            if let state = (child.value as? (any SwiftCLUIState)) {
                state.objectWillChange.sink { [weak self] in
                    self?.objectWillChange.send(())
                }.store(in: &bag)
            }
        }
    }
}
