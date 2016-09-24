#if os(Linux)

import XCTest
@testable import VaporMongoTests

XCTMain([
    testCase(DriverTests.allTests),
    testCase(ProviderTests.allTests),
])

#endif