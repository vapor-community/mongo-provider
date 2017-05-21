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
        
        let configDict = [
            "user": "username",
            "password": "password",
            "database": "test",
            "port": "27017",
            "host": "127.0.0.1"
        ]
        
        for (key, value) in configDict {
            try config.set("mongo.\(key)", value)
        }
        
        try config.set("fluent.driver", "mongo")
        try config.addProvider(MongoProvider.Provider.self)
        
        let drop = try! Droplet(config)
        XCTAssert(drop.database?.driver is MongoDriver)
    }
}
