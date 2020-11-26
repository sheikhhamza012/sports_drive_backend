json.error false
json.arena do 
    json.id @arena.id
    json.name @arena.name
    json.location @arena.location
    json.image @arena.image.url.nil? ?  'https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg' : arena.image.url
 end