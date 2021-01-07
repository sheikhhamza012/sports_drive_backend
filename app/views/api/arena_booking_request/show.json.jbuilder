json.request do 
   
    json.arena ({})
    # json.arena do
    #     json.id @request.arena.id
    #     json.name @request.arena.name
    #     json.location @request.arena.location
    #     json.image @request.arena.image.url.nil? ?  'https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg' : @request.arena.image.url
    # end
 end

json.error false

json.request do 
    json.id @request.id
    json.from_time @request.from_time
    json.to_time @request.to_time
    json.price @request.price
    json.status @request.status
    json.arena do
        json.id @request.field.group.arena.id
        json.name @request.field.group.arena.name
        json.location @request.field.group.arena.location
        json.image @request.field.group.arena.image.url.nil? ?  'https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg' : @request.field.group.arena.image.url
    end
 end