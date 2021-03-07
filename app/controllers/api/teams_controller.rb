class  Api::TeamsController < ApplicationController 
    def create
        team = Team.new(team_params)
        if params[:team][:image].nil?
            render json:{error:true, msg:"please select a picture"}
            return
        end
        team.image = params[:team][:image]
        team.captain = current_user
        team.save!
        render json:{error:false, team:team.attributes.slice('id', 'name', 'category', 'no_of_players', 'city', 'image','description')}
    rescue Exception => e
        msg = e.message
        render json: {error:true, msg: msg}
    end

    def get_allowed_individual_joining
        @requests = ArenaBookingRequest.where(status: "Accepted",allow_individual_requests: true).where('from_time >= ? or to_time > ?', Time.now, Time.now).order(:from_time)
        # @teams = []

        # request.each do |r|
        #     @teams << r.user.my_team
        # end
        # byebug
    end

    def get_challenge_teams
        @requests = ArenaBookingRequest.where(status: "Accepted",allow_challenge_requests: true).where('from_time >= ? or to_time > ?', Time.now, Time.now).order(:from_time)
        # @teams = []

        # request.each do |r|
        #     @teams << r.user.my_team
        # end
        # byebug
    end
    def challenge
        @challenge = current_user.challenge_requests_sent.create!(request_to:params[:user_id],arena_booking_request_id: params[:request_id])
        if @challenge
            render json:{error:false}
        else
            render json:{error:true, msg: "Unknown error occured"}

        end
    rescue Exception=>e
        render json:{error:true, msg: e.message}
    end
    def join
        token = params[:token]
        id = params[:id]
        if token.present?
            payload = JWT.decode(token, ENV['jwt_secret_key'], true, algorithm: 'HS256').first
            team = Team.find(payload["team_id"])
            status = :accepted
        elsif id.present?
            team = Team.find(id)
            status = :pending

        end
        if team.users.find_by(id: current_user.id).present?
            render json:{error:true, msg: "Already joined"}
        else
            @request = team.team_requests.create!(user: current_user,status: status)
            if @request
                render json:{error:false}
            else
                render json:{error:true,msg: "something went wrong"}
            end

        end
        
    rescue Exception=>e
        render json:{error:true, msg: e.message}

    end
    def index
        @my_teams = Team.where(captain: current_user)
    end
    private
    def team_params
        params.require(:team).permit(:name,:category,:no_of_players,:city,:description)
    end
end
