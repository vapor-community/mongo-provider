import PackageDescription

let package = Package(
    name: "VaporMongo",
    dependencies: [
    	.Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1),
		.Package(url: "https://github.com/vapor/mongo-driver.git", majorVersion: 1)
    ]
)
