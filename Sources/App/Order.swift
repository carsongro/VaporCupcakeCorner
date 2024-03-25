//
//  Order.swift
//
//
//  Created by Carson Gross on 3/24/24.
//

import FluentSQLiteDriver
import Vapor

struct OrderMigration: AsyncMigration {
    
    func prepare(on database: any FluentKit.Database) async throws {
        try await database.schema("orders")
            .field("id", .uuid, .identifier(auto: false))
            .field("cakeName", .string, .required)
            .field("buyerName", .string, .required)
            .field("date", .date)
            .create()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema("orders").delete()
    }
}

final class Order: Content, Model {
    static var schema = "orders"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "cakeName")
    var cakeName: String
    
    @Field(key: "buyerName")
    var buyerName: String
    
    @OptionalField(key: "date")
    var date: Date?
    
    init() { }
    
    init(
        id: UUID? = nil,
        cakeName: String,
        buyerName: String,
        date: Date? = nil
    ) {
        self.id = id
        self.cakeName = cakeName
        self.buyerName = buyerName
        self.date = date
    }
}
