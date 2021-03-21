json.error false
json.arena do
    json.merge! @group.arena.attributes.except("user_id","image")
    json.images (@group.arena.images.present? ? @group.arena.images.map(&:url) : ['https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg'] )
    json.groups @group.arena.groups do |group| 
        json.merge! group.attributes.except("arena_id")
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