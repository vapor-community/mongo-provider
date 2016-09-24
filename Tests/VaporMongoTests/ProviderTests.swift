import XCTest
import Fluent
@testable import VaporMongo
import Settings

class ProviderTests: XCTestCase {
    static var allTests = [
        ("testBasic", testBasic)
    ]

    func testBasic() throws {
        let config = try Config(node: [
            "mongo": [
                "database": "test",
                "user": "test",
                "password": "test",
                "host": "127.0.0.1"
            ]
        ])

        do {
            let provider = try Provider(config: config)
            print(provider.driver.idKey)
        } catch {
            XCTFail("Could not init: \(error)")
        }
    }
}
