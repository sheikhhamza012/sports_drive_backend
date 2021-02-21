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
    def index
        @my_teams = Team.where(captain: current_user)
    end
    private
    def team_params
        params.require(:team).permit(:name,:category,:no_of_players,:city,:description)
    end
end
