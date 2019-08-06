class Application

    def call(env)
        resp = Rack::Response.new 
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            item = Item.all.find {|item| item.name == item_name}
            if item
                resp.write item.price
                resp.status = 200
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end
end
            
        


# gets '/items/:name' do
#     if @@items.include?(name) == true
#       return @@item.name.price
#     elif @@items.include?(name) == false
#       return "error 400 Item not found"
#     else
#       return "error 404 bad route"
#     end
#   end