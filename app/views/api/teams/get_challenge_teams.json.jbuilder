json.error false
json.teams @requests do |r|
    json.from_time r.from_time
    json.category r.field.group.name
    json.venue r.field.group.arena.name
    json.rating r.field.group.arena.rating
    if r.user.my_team
        json.team do 
            json.id r.user.my_team.id
            json.name r.user.my_team.name
            json.image r.user.my_team.image.url.nil? ?  'https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg' : r.user.my_team.image.url
            json.allow_join !current_user.challenge_requests_sent.where(request_to: r.user,arena_booking_request_id: r.id).present?
        end
    end
    json.user do
        json.allow_join !current_user.challenge_requests_sent.where(request_to: r.user,arena_booking_request_id: r.id).present?
        json.name "#{r.user.first_name} #{r.user.last_name}"
        json.id r.user.id
        json.image r.user.image.url.nil? ?  'https://acadianakarate.com/wp-content/uploads/2017/04/default-image-620x600.jpg' : r.user.image.url
    end
    json.request_id r.id
end