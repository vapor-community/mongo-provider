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
    public let provided: Providable

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
        let database = Database(driver)
        provided = Providable(database: database)
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

    public func afterInit(_ drop: Droplet) {

    }

    public func beforeRun(_ drop: Droplet) {

    }
}
