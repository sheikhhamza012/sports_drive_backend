json.error false
json.group do
    json.image (@group.arena.images.present? ? @group.arena.images.first.url : 'https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg' )
    json.merge! @group.arena.attributes.slice("rating","location")
    json.arena_name @group.arena.attributes['name']
    json.merge! @group.attributes.except("arena_id")
    json.fields @group.fields do |field| 
        json.merge! field.attributes.except("group_id")
        json.image (field.image.url.nil? ? "https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg" :  field.image.url)
        json.prices field.prices do |price| 
            json.merge! price.attributes.except("priceable_id","priceable_type")
        end
    end
    json.prices @group.prices do |price| 
        json.merge! price.attributes.except("priceable_id","priceable_type")
    end
end