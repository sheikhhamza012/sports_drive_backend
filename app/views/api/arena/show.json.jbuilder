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
        json.field_type group.fields.first.field_type
        json.fields group.fields do |field|
            json.id field.id
            if params[:arena_booking_request].present? && params[:arena_booking_request][:from_time].present? &&  params[:arena_booking_request][:to_time].present?
                json.available field.check_availabilty(params[:arena_booking_request][:from_time], params[:arena_booking_request][:to_time])
            else
                json.available true
            end
            json.field_type field.field_type
            json.image field.image.url.nil? ?  'https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg' : field.image.url
        end
    end
end