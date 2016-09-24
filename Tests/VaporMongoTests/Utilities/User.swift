//
//  User.swift
//  FluentMongo
//
//  Created by Paul Rolfe on 9/10/16.
//
//

import Fluent

final class User: Entity {
    var id: Fluent.Node?
    var name: String
    var email: String
    var exists = false
    
    init(id: Node?, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "_id": id,
            "name": name,
            "email": email
        ])
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("_id")
        name = try node.extract("name")
        email = try node.extract("email")
    }
    
    static func prepare(_ database: Fluent.Database) throws {}
    static func revert(_ database: Fluent.Database) throws {}
}
