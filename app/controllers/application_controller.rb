class ApplicationController < ActionController::Base
    include ApplicationHelper
    skip_before_action :verify_authenticity_token
    before_action :authorise
    include Pundit

    def authorise
        token = request.headers['Authorization']
        if token.nil?
            raise Exception.new("User not authorised for this action")
        end
        payload = JWT.decode(token, ENV['jwt_secret_key'], true, algorithm: 'HS256').first        
        if payload["user_id"].nil?
            raise Exception.new("Auth token Invalid")
        end
        @current_user = User.find(payload["user_id"])
    rescue Exception => e
        msg=e.message
        if e.class.to_s == "JWT::DecodeError"
            msg="Auth token invalid"
        end
        render json: {error:true,  msg: msg}
    end
end
