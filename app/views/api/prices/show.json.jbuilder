json.error false
json.arena do 
    json.id @arena.id
    json.rating @arena.rating
    json.name @arena.name
    json.location @arena.location
    json.images @arena.images.present? ? @arena.arena.images.map(&:url) : ['https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg'] 
    json.groups @arena.groups do |group|
        json.id group.id
        json.name group.name
        json.field_type group.fields.first.field_type
        json.fields group.fields do |field|
            json.id field.id
            json.image field.image.url.nil? ?  'https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg' : field.image.url
            json.prices field.prices do |price| 
                json.merge! price.attributes.except("priceable_id","priceable_type")
            end
        end
    end
end