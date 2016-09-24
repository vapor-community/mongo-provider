import XCTest

import Fluent
@testable import FluentMongo

/**
    To run these tests you must have `mongod`
    running with the following configuration.
 
    - user: test
    - password: test
    - localhost: test
    - port: 27017
*/
class DriverTests: XCTestCase {
    static var allTests : [(String, (DriverTests) -> () throws -> Void)] {
        return [
            ("testConnectFailing", testConnectFailing),
            ("testSaveClearFind", testSaveClearFind),
        ]
    }
    
    var database: Fluent.Database!
    var driver: MongoDriver!
    
    override func setUp() {
        driver = MongoDriver.makeTestConnection()
        database = Database(driver)
        clearUserCollection()
    }
    
    func clearUserCollection() {
        let _ = try? database.delete(User.entity)
    }
    
    func createUser() -> User {
        var user = User(id: nil, name: "Vapor", email: "vapor@qutheory.io")
        User.database = database
        
        do {
            try user.save()
            print("JUST SAVED")
        } catch {
            XCTFail("Could not save: \(error)")
        }
        return user
    }

    func testConnectFailing() {
        do {
            let _ = try MongoDriver(database: "test", user: "test", password: "test", host: "localhost", port: 500)
            XCTFail("Should not connect.")
        } catch {
            // This should fail.
        }
    }
    
    func testSaveClearFind() {
        // Test inserting a record then dropping the collection
        let _ = createUser()
        var all = try? User.all()
        XCTAssert(all?.count == 1)
        clearUserCollection()
        all = try? User.all()
        XCTAssert(all?.count == 0)
        
        // Test finding record by id
        let user = createUser()
        do {
            let found = try User.find(user.id!)
            XCTAssertEqual(found?.id?.string, user.id?.string)
            XCTAssertEqual(found?.name, user.name)
            XCTAssertEqual(found?.email, user.email)
        } catch {
            XCTFail("Could not find user: \(error)")
        }
        
        do {
            let user = try User.find(2)
            XCTAssertNil(user)
        } catch {
            XCTFail("Could not find user: \(error)")
        }
    }

    func testModify() throws {
        User.database = database
        do {
            var user = User(id: nil, name: "Vapor", email: "mongo@vapor.codes")
            try user.save()

            guard let id = user.id else {
                XCTFail("No user id")
                return
            }

            guard var fetch = try User.find(id) else {
                XCTFail("Could not fetch user")
                return
            }

            XCTAssertEqual(fetch.name, user.name)

            fetch.name = "Vapor2"
            try fetch.save()

            guard let verify = try User.find(id) else {
                XCTFail("Could not fetch verify")
                return
            }
            XCTAssertEqual(fetch.name, verify.name)
        } catch {
            XCTFail("Could not modify: \(error)")
        }
    }
}
