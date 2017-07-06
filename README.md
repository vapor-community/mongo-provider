<p align="center">
    <img 
        src="https://thumbsplus.tutsplus.com/uploads/users/1116/posts/24835/preview_image/mongodb-logo.png?height=300&width=300" 
        align="center" 
        alt="Mongo"
        width="300px"
    >
</p>

# Mongo Provider

![Swift](http://img.shields.io/badge/swift-3.0-brightgreen.svg)
[![CircleCI](https://circleci.com/gh/vapor/mongo-provider.svg?style=shield)](https://circleci.com/gh/vapor-community/mongo-provider)
[![Slack Status](http://vapor.team/badge.svg)](http://vapor.team)

## ⬇ Install the MongoDB server

### OS X

For more instructions, check out https://docs.mongodb.com/master/administration/install-community/.

```shell
brew install mongodb
```

### Linux

```shell
sudo apt-get update
sudo apt-get install mongodb
```

### Run the server

```shell
mongod
```

## 📦 Add Provider

Now to use Mongo in your Vapor project.

### Package

Add the package to your `Package.swift`.

```swift
.Package(url: "https://github.com/vapor/mongo-provider.git", majorVersion: 2)
```

### Droplet

Add the provider to your Droplet.

```swift
import Vapor
import MongoProvider

let drop = Droplet()
try drop.addProvider(MongoProvider.Provider.self)
```

### Config

Then add a `mongo.json` to your `Config` folder. You can add it in the root or keep it out of git in the secrets folder.

```
Config/
  - mongo.json
    secrets/
      - mongo.json
```

The secrets folder is under the `.gitignore` and shouldn't be committed.

Here's an example `secrets/mongo.json`

```json
{
  "url": "mongodb://<db-user>:<db-password>@<host>:<port>/<database>"
}
```

> Note: `port` and `host` are optional.

### Manual

You can also manually configure the provider in code. This will bypass the configuration files.

```swift
import Vapor
import MongoProvider

let drop = Droplet()

let mongo = try MongoProvider.Provider(database: ..., user: ..., password: ...)
drop.addProvider(mongo)
```

## 📖 Documentation

Visit the Vapor web framework's [documentation](http://docs.vapor.codes) for more instructions on how to use this package.

## 💧 Community

Join the welcoming community of fellow Vapor developers in [slack](http://vapor.team).

## 🔧 Compatibility

This package has been tested on macOS and Ubuntu.

