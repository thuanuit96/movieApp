

import Foundation
@testable import MovieApp

public func ==<T>(lhs: Result<T>, rhs: Result<T>) -> Bool {
    return String(describing: lhs) == String(describing: rhs)
}
