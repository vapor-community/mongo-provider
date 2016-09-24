import Vapor
import FluentMongo

public final class Provider: Vapor.Provider {
    /**
        MySQL database driver created by the provider.
    */
    public let driver: MongoDriver

    /**
        MySQL database created by the provider.
    */
    public let database: DatabaseDriver?

    /**
        Creates a new `MongoDriver` with
        the given database name, credentials, and port.
    */
    public init(
        database: String,
        user: String,
        password: String,
        host: String = "localhost",
        port: Int = 27017
    ) throws {
        let driver = try MongoDriver(database: database, user: user, password: password, host: host, port: port)
        self.driver = driver
        self.database = driver
    }

    public func boot(with application: Application) { }
}
