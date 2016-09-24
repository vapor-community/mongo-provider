# Mongo Provider

![Swift](http://img.shields.io/badge/swift-3.0-brightgreen.svg)
[![CircleCI](https://circleci.com/gh/vapor/mongo-provider.svg?style=shield)](https://circleci.com/gh/vapor/mongo-provider)
[![Slack Status](http://vapor.team/badge.svg)](http://vapor.team)

## ⬇ Install Mongo

### OS X

```shell
brew install mongo
```

### Linux

```shell
sudo apt-get update
sudo apt-get install mongo
```

### Run

```shell
mongod
```

## 📦 Add Provider

Now to use Mongo in your Vapor project.

### Package

Add the package to your `Package.swift`.

```swift
.Package(url: "https://github.com/vapor/mongo-provider.git", majorVersion: 1, minor: 0)
```

### Droplet

Add the provider to your Droplet.

```swift
import Vapor
import VaporMongo

let drop = Droplet(providers: [VaporMongo.Provider.self])
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
  "user": "username",
  "password": "badpassword",
  "database": "databasename",
  "port": "27017", // optional
  "host": "z99a0.asdf8c8cx.us-east-1.rds.amazonaws.com", // optional
}
```

### Manual

You can also manually configure the provider in code. This will bypass the configuration files.

```swift
import Vapor
import VaporMongo

let mongo = VaporMongo.Provider(user: ..., password: ...)

let drop = Droplet(initializedProviders: [mongo])
```

## 📖 Documentation

Visit the Vapor web framework's [documentation](http://docs.vapor.codes) for more instructions on how to use this package.

## 💧 Community

Join the welcoming community of fellow Vapor developers in [slack](http://vapor.team).

## 🔧 Compatibility

This package has been tested on macOS and Ubuntu.

