json.error false
if @token&.to_s
    json.auth_token @token
end
json.user do
    json.id current_user.id
    json.first_name current_user.first_name
    json.last_name current_user.last_name
    json.email current_user.email
    json.phone current_user.phone
    json.city current_user.city
    json.isVendor current_user.isVendor
    json.about current_user.about
    json.featured current_user.featured
    json.rating current_user.rating
    json.player_of current_user.player_of
    json.image current_user.image.url.nil? ?  'https://s3.amazonaws.com/37assets/svn/765-default-avatar.png' : current_user.image.url
 end