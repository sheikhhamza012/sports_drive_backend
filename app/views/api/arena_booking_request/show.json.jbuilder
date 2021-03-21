if @request.nil?
    json.request ({})
else   
    json.error false
    json.request do 
        json.id @request.id
        json.from_time @request.from_time
        json.to_time @request.to_time
        json.price @request.price
        json.status @request.status
        json.field do
            json.name @request.field.name
            json.id @request.field.id
        end
        json.arena do
            json.id @request.field.group.arena.id
            json.name @request.field.group.arena.name
            json.location @request.field.group.arena.location
            json.images @request.field.group.arena.images.present? ? @request.field.group.arena.images.map(&:url) : ['https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg'] 
        end
    end
end
