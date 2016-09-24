#if os(Linux)

import XCTest
@testable import FluentMySQLTests

XCTMain([
    testCase(MySQLTests.allTests),
    testCase(MySQLDriverTests.allTests),
])

#endif