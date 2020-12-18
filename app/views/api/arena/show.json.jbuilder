json.error false
json.arena do 
    json.id @arena.id
    json.rating @arena.rating
    json.name @arena.name
    json.location @arena.location
    json.image @arena.image.url.nil? ?  'https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg' : arena.image.url
    json.groups @arena.groups do |group|
        json.id group.id
        json.name group.name
        json.type group.fields.first.field_type
        json.fields group.fields do |field|
            json.id field.id
            json.image field.image.url.nil? ?  'https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg' : field.image.url
        end
    end
end