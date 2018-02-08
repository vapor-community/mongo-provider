import PackageDescription

let package = Package(
    name: "MongoProvider",
    dependencies: [
        // MongoDB driver for Fluent
        .package(url: "https://github.com/vapor/mongo-driver.git", .upToNextMajor(from: "2.2.1")),
        // A provider for including Fluent in Vapor applications
        .package(url: "https://github.com/vapor/fluent-provider.git", .upToNextMajor(from: "1.3.0")),
        // A web framework and server for Swift that works on macOS and Ubuntu.
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "2.4.4")),
    ]
)
