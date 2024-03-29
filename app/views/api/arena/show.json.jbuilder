json.error false
json.arena do 
    json.id @arena.id
    json.rating @arena.rating
    json.name @arena.name
    json.location @arena.location
    json.images @arena.images.present? ? @arena.images.map(&:url) : ['https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg'] 
    json.groups @arena.groups do |group|
        json.prices group.prices do |price| 
            json.merge! price.attributes.except("priceable_id","priceable_type")
        end
        json.merge! group.attributes.except("arena_id","priceable_type")
        json.field_type group.fields.first.field_type
        json.fields group.fields do |field|
            json.merge! field.attributes.except("image","group_id")
            json.prices field.prices.where(date: params[:arena_booking_request]&.fetch(:from_time).nil? ? nil : Date.parse(params[:arena_booking_request][:from_time]).all_day) do |price| 
                json.merge! price.attributes.except("priceable_id","priceable_type")
            end
            if params[:arena_booking_request].present? && params[:arena_booking_request][:from_time].present? &&  params[:arena_booking_request][:to_time].present?
                json.available field.check_availabilty(params[:arena_booking_request][:from_time], params[:arena_booking_request][:to_time])
            else
                json.available true
            end
            json.image field.image.url.nil? ?  'https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg' : field.image.url
        end
    end
end