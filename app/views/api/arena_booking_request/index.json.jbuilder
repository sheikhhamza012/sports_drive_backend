json.error false
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