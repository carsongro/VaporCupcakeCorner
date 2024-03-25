//
//  Cupcake.swift
//
//
//  Created by Carson Gross on 3/24/24.
//

import FluentSQLiteDriver
import Foundation
import Vapor

struct CupcakeMigration: AsyncMigration {
    
    func prepare(on database: any FluentKit.Database) async throws {
        try await database.schema("cupcakes")
            .field("id", .uuid, .identifier(auto: false))
            .field("name", .string, .required)
            .field("description", .string, .required)
            .field("price", .int, .required)
            .create()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema("cupcakes").delete()
    }
}

final class Cupcake: Content, Model {
    
    static var schema = "cupcakes"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "price")
    var price: Int
    
    init() { }
    
    init(
        id: UUID? = nil,
        name: String,
        description: String,
        price: Int
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
    }
}
