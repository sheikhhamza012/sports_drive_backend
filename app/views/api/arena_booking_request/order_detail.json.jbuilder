json.error false
json.request do
    json.id @arena_booking_request.id
    json.field_name @arena_booking_request.field.name
    json.from_time @arena_booking_request.from_time
    json.to_time @arena_booking_request.to_time
    json.price @arena_booking_request.price
    json.user @arena_booking_request.user
end