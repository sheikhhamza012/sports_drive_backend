json.error false
json.arenas @arenas do |arena|
    json.id arena.id
    json.name arena.name
    json.location arena.location
    json.images arena.images.present? ? arena.images.map(&:url) : ['https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg'] 
    json.groups arena.groups do |group| 
        json.merge! group.attributes.except("arena_id")
        json.field_type group.fields.first.field_type
        json.fields group.fields do |field| 
            json.merge! field.attributes.except("group_id")
            json.image (field.image.url.nil? ? "https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg" :  field.image.url)
            json.prices field.prices do |price| 
                json.merge! price.attributes.except("priceable_id","priceable_type")
            end
        end
        json.prices group.prices do |price| 
            json.merge! price.attributes.except("priceable_id","priceable_type")
        end
    end
end