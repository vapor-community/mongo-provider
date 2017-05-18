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
        
        guard let url = mongo["url"]?.string else {
            throw ConfigError.missing(
                key: ["url"],
                file: "mongo",
                desiredType: String.self
            )
        }
        
        let maxConnectionsPerServer = mongo["maxConnectionsPerServer"]?.int ?? 100
        
        try self.init(url, maxConnectionsPerServer: maxConnectionsPerServer)
    }
}
