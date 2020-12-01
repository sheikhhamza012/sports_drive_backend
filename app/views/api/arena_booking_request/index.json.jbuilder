json.error false
if @active_request.present?
    json.active_request do 
        json.id @active_request.id
        json.from_time @active_request.from_time
        json.to_time @active_request.to_time
        json.price @active_request.price
        json.status @active_request.status
        json.arena do
            json.id @active_request.arena.id
            json.name @active_request.arena.name
            json.location @active_request.arena.location
            json.image @active_request.arena.image.url.nil? ?  'https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg' : @active_request.arena.image.url
        end
     end
else
    json.active_request nil
end
json.requests @requests do |r|
    json.id r.id
    json.from_time r.from_time
    json.to_time r.to_time
    json.price r.price
    json.status r.status
    json.arena do
        json.id r.arena.id
        json.name r.arena.name
        json.location r.arena.location
        json.image r.arena.image.url.nil? ?  'https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg' : r.arena.image.url
    end
 end