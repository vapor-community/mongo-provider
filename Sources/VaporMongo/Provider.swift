import Vapor
import FluentMongo

public final class Provider: Vapor.Provider {
    /**
        Mongo database driver created by the provider.
    */
    public let driver: MongoDriver

    /**
        Mongo database created by the provider.
    */
    public let database: Database

    public enum Error: Swift.Error {
        case config(String)
    }

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
        let driver = try MongoDriver(
            database: database,
            user: user,
            password: password,
            host: host,
            port: port
        )
        self.driver = driver
        self.database = Database(driver)
    }

    public convenience init(config: Config) throws {
        guard let mongo = config["mongo"]?.object else {
            throw Error.config("No mongo.json config file.")
        }

        guard let database = mongo["database"]?.string else {
            throw Error.config("No 'database' key in mongo.json config file.")
        }

        guard let user = mongo["user"]?.string else {
            throw Error.config("No 'user' key in mongo.json config file.")
        }

        guard let password = mongo["password"]?.string else {
            throw Error.config("No 'password' key in mongo.json config file.")
        }

        let host = mongo["host"]?.string ?? "localhost"
        let port = mongo["port"]?.int ?? 27017

        try self.init(
            database: database,
            user: user,
            password: password,
            host: host,
            port: port
        )
    }
    
    public func boot(_ drop: Droplet) {
        drop.database = database
    }

    public func afterInit(_ drop: Droplet) {

    }

    public func beforeRun(_ drop: Droplet) {

    }
}
