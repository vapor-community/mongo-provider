import XCTest
import Fluent
import Vapor
import MongoProvider

class ProviderTests: XCTestCase {
    static var allTests = [
        ("testBasic", testBasic)
    ]

    func testBasic() throws {
        var config = Config([:])
        try config.set("fluent.driver", "mongo")
        try config.set("mongo.url", "mongodb://test:test@127.0.0.1/test")
        try config.addProvider(MongoProvider.Provider.self)
        
        let drop = try! Droplet(config)
        XCTAssert(drop.database?.driver is MongoDriver)
    }
}
