import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // register routes
    
    let directory = app.directory.workingDirectory
    app.databases.use(.sqlite(.file("\(directory)cupcakes.sqlite")), as: .sqlite)
    app.migrations.add(CupcakeMigration(), to: .sqlite)
    app.migrations.add(OrderMigration(), to: .sqlite)
    
    app.views.use(.leaf)
    
    try await routes(app)
}
