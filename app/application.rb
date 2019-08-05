class Application
    @@items = []
    def call(env)
        req = Rack::Request.new(env)
        resp = Rack::Response.new(env)

        names = @@items.map {|item| item.name}
        if req.path.match(/items/)
            search_item = req.path.split("/items/").last
            found = false
            @@items.each do |item|
                if item.name == search_item
                    resp.write(item.price)
                    found = true
                end
            end
            if found == false
                resp.write("Item not found")
                resp.status = 400
            end
        else
            resp.write("Route not found")
            resp.status = 404
        end
        resp.finish
    end
end