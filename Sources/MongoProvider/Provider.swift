import Vapor
import MongoDriver
import FluentProvider

public final class Provider: Vapor.Provider {
    /// This should be the name of the actual repository
    /// that contains the Provider.
    ///
    /// this will be used for things like providing
    /// resources
    ///
    /// this will default to stripped camel casing,
    /// for example MyProvider will become `my-provider`
    /// if your Provider is providing resources
    /// it is HIGHLY recommended to provide a static let
    /// for performance considerations
    public static let repositoryName: String = "mongo-provider"
    
    public init(config: Config) throws {}

    /// Called after the provider has initialized
    /// in the `Config.addProvider` call.
    public func boot(_ config: Config) throws {
        try config.addProvider(FluentProvider.Provider.self)
        config.addConfigurable(driver: MongoDriver.init, name: "mongo")
    }
    
    /// Called after the Droplet has initialized.
    public func boot(_ droplet: Droplet) throws { }
    
    /// Called before the Droplet begins serving
    /// which is @noreturn.
    public func beforeRun(_ droplet: Droplet) throws { }
}


extension MongoDriver: ConfigInitializable {
    public convenience init(config: Config) throws {
        
        guard let mongo = config["mongo"] else {
            throw ConfigError.missingFile("mongo")
        }
        
        func buildUrl(mongo: Config) throws -> String {
            
            // For type safety, declare all config strings once with enum
            enum Keys: String {
                case
                    user,
                    password,
                    database,
                    port,
                    host
            }
            
            // Get a valid config value, or throw a related error
            func configValue(key: String) throws -> String {
                
                guard let cValue = mongo[key]?.string else {
                    throw ConfigError.missing(
                        key: [key],
                        file: "mongo",
                        desiredType: String.self
                    )
                }
                
                return cValue
                
            }
            
            let user = try configValue(key: Keys.user.rawValue)
            let password = try configValue(key: Keys.password.rawValue)
            let database = try configValue(key: Keys.database.rawValue)
            let port = try configValue(key: Keys.port.rawValue)
            let host = try configValue(key: Keys.host.rawValue)
            
            // If valid credentials are not specified, don't add the syntax around them
            let userPasswordComponent =
                user.characters.count == 0 && password.characters.count == 0
                    ? ""
                    : "\(user):\(password)@"
            
            return "mongodb://\(userPasswordComponent)\(host):\(port)/\(database)"
        }
        
        let maxConnectionsPerServer = mongo["maxConnectionsPerServer"]?.int ?? 100
        
        let url = try buildUrl(mongo: mongo)
        
        try self.init(url, maxConnectionsPerServer: maxConnectionsPerServer)
    }
}
