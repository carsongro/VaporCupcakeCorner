import Fluent
import Leaf
import Vapor

func routes(_ app: Application) async throws {
    app.get { req -> View in
        struct PageData: Content {
            var cupcakes: [Cupcake]
            var orders: [Order]
        }
        
        async let cupcakes = Cupcake.query(on: req.db).all()
        async let orders = Order.query(on: req.db).all()
        
        let context = PageData(cupcakes: try await cupcakes, orders: try await orders)
        
        return try await req.view.render("home", context)
    }
    
    app.get("cupcakes") { req async throws -> [Cupcake] in
        try await Cupcake.query(on: req.db).sort(\.$name).all()
    }
    
    app.post("add") { req async throws -> Response in
        let cupcake = try req.content.decode(Cupcake.self)
        
        try await cupcake.save(on: req.db)
        
        return req.redirect(to: "/")
    }
    
    app.post("order") { req async throws -> Order in
        let order = try req.content.decode(Order.self)
        order.date = Date()
        
        try await order.save(on: req.db)
        
        return order
    }
}
