json.error false
if @token&.to_s
    json.auth_token @token
end
json.user do
    json.merge! current_user.attributes.except("image","encrypted_password","reset_password_token","reset_password_sent_at","remember_created_at")
    if current_user.vendor_detail
        json.vendor_detail do
            json.id_card current_user.vendor_detail&.id_card
            json.request_status current_user.vendor_detail&.request_status
        end
    end
    json.image current_user.image.url.nil? ?  'https://s3.amazonaws.com/37assets/svn/765-default-avatar.png' : current_user.image.url
 end