#if os(Linux)

import XCTest
@testable import MongoProviderTests

XCTMain([
    testCase(ProviderTests.allTests),
])

#endif
